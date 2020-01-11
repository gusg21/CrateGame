extends Node2D

func loadMap(num):
	var map_scene = load("res://Map" + num + ".tscn")
	print(map_scene)
	var map = map_scene.instance()
	print(map)
	add_child(map)

func _ready():
	loadMap("1")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()