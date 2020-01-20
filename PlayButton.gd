extends TextureButton

func _on_TextureButton_button_up():
	var map_scn_resrc = load("res://Main.tscn")
	var map_scn = map_scn_resrc.instance()
	
	if map_scn.chooseMap(get_node("/root/Menu/Map Select/Map Selector").get_selected_path()) != null:
		$"/root/Menu/Map Select/LoadError".show()
		return
		
	get_node("/root/Menu").queue_free()
	get_tree().get_root().add_child(map_scn)