extends Node2D

export(NodePath) var caster
export(NodePath) var camera

const PARTICLES = preload("res://GrappleParticles.tscn")

var speed = 4
var pull_speed = 40
var direction = Vector2.RIGHT
var contact_offset = Vector2.ZERO
var other = null
var is_boosted = false
var boost_power = 1500

func _physics_process(delta):
	var caster_node = get_node(caster)
	
	if other != null:
		direction = -(caster_node.global_position - global_position).normalized()
		other.add_central_force(-(direction * pull_speed))
		position = other.position - contact_offset
	else:
		position += direction * speed
	
	if caster_node.player_2 && Input.is_action_just_pressed("player2_grapple"):
		die(true)
	
	if !caster_node.player_2 && Input.is_action_just_pressed("player1_grapple"):
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
	if other != null:
		return
	
	if body == get_node(caster) and other == null:
		return
		
	if not "linear_velocity" in body and other == null: # wall
		die(true)
		return
		
	if is_boosted:
		body.linear_velocity = direction * boost_power
		get_node("/root/Main/Camera2D").shake()
		die(true)
	
	contact_offset = body.position - position
	other = body
	get_parent().get_parent().get_node("CrunchSound").play()