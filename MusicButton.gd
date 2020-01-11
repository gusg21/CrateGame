extends Button

const TEXTURES = [preload("res://Assets/Symbols/music-off.png"), preload("res://Assets/Symbols/music-on.png")]

func _on_Music_Button_button_up():
	Global.MUSIC = !Global.MUSIC
	
	icon = TEXTURES[1 if Global.MUSIC else 0]
	
	AudioServer.set_bus_volume_db(1, 0 if Global.MUSIC else -80)

func _on_Music_Button_button_down():
	(get_parent().get_node("ClickSound") as AudioStreamPlayer).play()
