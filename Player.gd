extends RigidBody2D

export(float) var move_speed = 300
export(bool) var player_2 = false setget setTex
export(Font) var healthFont

const GRAPPLING_HOOK = preload("res://GrapplingHook.tscn")
const PLAYER_GRAPHICS = [preload("Assets/Characters/player1.png"), preload("Assets/Characters/player2.png")]
var can_grapple = true
var grapple_dir = Vector2.ZERO
var velocity = Vector2.ZERO
const MAX_HEALTH : float = 20.0
var health : float = MAX_HEALTH
var crate_colliding = 0
var moving = false
var dead = false
var boosts = 0

func setTex(to):
	print(player_2)
	$Graphics.set_texture(PLAYER_GRAPHICS[1 if player_2 else 0])
	player_2 = to

func ready():
	setTex(player_2)

func btoi(b):
	return 1 if b else 0

func grapple():
	var hook = GRAPPLING_HOOK.instance()
	
	hook.position = position
	hook.direction = grapple_dir.normalized()
	hook.caster = self.get_path()
	if boosts > 0:
		boosts -= 1
		hook.is_boosted = true
	
	get_parent().add_child(hook, true)
	
	can_grapple = false
	$Cooldowns/Grapple.start()

func get_movement():
	var velocity = Vector2.ZERO
	
	velocity.x = (btoi(Input.is_action_pressed("player1_right")) - btoi(Input.is_action_pressed("player1_left")))
	velocity.y = (btoi(Input.is_action_pressed("player1_down")) - btoi(Input.is_action_pressed("player1_up")))
	
	velocity = velocity.normalized() * move_speed
	
	return velocity
	
func grapple_button():
	return Input.is_action_just_pressed("player1_grapple")

func _physics_process(delta):
	if dead:
		dead_update()
		return
	
	velocity = get_movement()
	
	moving = false
	if (velocity.length() > 0.1):
		moving = true
		
		if (velocity.x > 0):
			$Graphics.flip_h = false
		else:
			$Graphics.flip_h = true
		
		if $Cooldowns/Step.is_stopped():
			$Cooldowns/Step.start()
			get_parent().get_parent().get_node("StepSound").play()
	
	linear_velocity = lerp(linear_velocity, velocity, 0.2)
	
	if linear_velocity.length() > 10:
		grapple_dir = linear_velocity
	
	if grapple_button() and \
			grapple_dir != Vector2.ZERO and \
			can_grapple:
		grapple()
		
	if crate_colliding != 0:
		health -= 0.2
	
	if health <= 0:
		die()
		
	health = clamp(health, -1000, MAX_HEALTH)
	
	update()
	
func dead_update():
	collision_mask = 0
	linear_velocity.y += 1
	position += linear_velocity
	rotation += 0.1

func die():
	pause_mode = Node.PAUSE_MODE_PROCESS
	get_tree().paused = true
	
	Global.WINNER_P2 = !player_2
	
	dead = true
	linear_velocity = Vector2(0, -10)
	angular_velocity = 1
	
	$Cooldowns/Die.start()
	
	get_parent().get_parent().get_node("DieSound").play()

func char_str(c, count):
	var s = ""
	for i in range(count):
		s += c
	return s

func _draw():
	var position = Vector2(-8, -10)
	
	draw_line(position, position + Vector2(16, 0), Color.red, 2)
	draw_line(position, position + Vector2((health / MAX_HEALTH) * 16, 0), Color.green, 2)

	draw_string(healthFont, position - Vector2(0, 5), "H:" + str(clamp(round(health), 0, MAX_HEALTH)))
	if boosts > 0:
		draw_string(healthFont, position - Vector2(0, 12), "B" + char_str("-", boosts), Color.aquamarine)

func _on_Grapple_timeout():
	can_grapple = true

func _on_Area2D_body_entered(body):
	crate_colliding += 1

func _on_Area2D_body_exited(body):
	crate_colliding -= 1


func _on_Step_timeout():
	if moving:
		$Cooldowns/Step.start()
		get_parent().get_parent().get_node("StepSound").play()

func _on_Die_timeout():
	get_tree().change_scene("res://GameOver.tscn")
	get_tree().paused = false
