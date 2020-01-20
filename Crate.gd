extends RigidBody2D

func _ready():
	#bounce = 1
	friction = 0

func _process(delta):
	applied_force = applied_force.clamped(2000)

func _on_Area2D_body_entered(body):
	print("Crate collided with: " + body.name)
	applied_force = Vector2.ZERO
