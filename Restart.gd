extends Button

func restart_game():
	get_tree().change_scene("res://Main.tscn")

func _on_Restart_pressed():
	if visible:
		restart_game()