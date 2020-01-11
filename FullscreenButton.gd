extends Button

#func _on_Fullscreen_Button_pressed():
#	OS.window_fullscreen = !OS.window_fullscreen

func _on_Fullscreen_Button_button_up():
	OS.window_fullscreen = !OS.window_fullscreen

func _on_Fullscreen_Button_button_down():
	(get_parent().get_node("ClickSound") as AudioStreamPlayer).play()