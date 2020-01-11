extends Node2D

export(NodePath) var caster

const PARTICLES = preload("res://GrappleParticles.tscn")

var speed = 4
var direction = Vector2.RIGHT
var contact_offset = Vector2.ZERO
var other = null
var is_boosted = false

func _physics_process(delta):
	if is_queued_for_deletion():
		return
	
	if other != null:
		direction = lerp(direction, (get_node(caster).position - position).normalized() * speed * 60, 0.03)
		other.linear_velocity = direction
		position = other.position - contact_offset
	else:
		position += direction * speed
	
	if get_node(caster).player_2 && Input.is_action_just_pressed("player2_grapple"):
		die(true)
	
	if !get_node(caster).player_2 && Input.is_action_just_pressed("player1_grapple"):
		die(true)
	
	update()

func die(party:bool):
	queue_free()
	
	if not party:
		return
	
	var p = PARTICLES.instance()
	p.position = position
	p.emitting = true
	get_parent().add_child(p)

func _draw():
	draw_line(to_local(global_position), to_local(get_node(caster).global_position), Color("#8f974a"), 2)

func _on_Area2D_body_entered(body):
	if body == get_node(caster) and other == null:
		return
	
	if other != null: # double collision
		die(false)
		return
		
	if not "linear_velocity" in body: # wall
		die(true)
		return
		
	if is_boosted:
		body.linear_velocity = direction * 1500
		die(true)
	
	direction = -direction * speed
	contact_offset = body.position - position
	other = body
	get_parent().get_parent().get_node("CrunchSound").play()