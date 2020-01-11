extends RigidBody2D

var target = null
var elapsed = 0

func _process(delta):
	elapsed += delta
	
	if target == null:
		linear_velocity = Vector2.ZERO
		$Graphics.rotation = 0
		return
	
	linear_velocity = lerp(linear_velocity, (target.global_position - global_position).normalized() * 150, 0.1)

	$Graphics.rotation_degrees = sin(elapsed * 20) * 10

func _on_Watch_Area_body_entered(body):
	print("Following: " + body.name)
	target = body

func _on_Escape_Area_body_exited(body):
	target = null
