extends "res://Player.gd"

func get_movement():
	return Vector2(
		Input.get_joy_axis(0, 0),
		Input.get_joy_axis(0, 1)
		) * move_speed
		
func grapple_button():
	return Input.is_action_just_pressed("player2_grapple")

func _ready():
	player_2 = true
	setTex(player_2)