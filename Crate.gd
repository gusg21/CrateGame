extends RigidBody2D

func _ready():
	#bounce = 1
	friction = 0


func _on_Area2D_body_entered(body):
	print("Crate collided")
	applied_force = Vector2.ZERO
