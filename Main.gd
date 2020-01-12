extends Node2D

func loadMap(num):
	var map_scene = load("res://Map" + num + ".tscn")
	print(map_scene)
	var map = map_scene.instance()
	print(map)
	add_child(map)
	
func fixWalls():
	var tilemap = (get_node("Map") as TileMap)
	
	# tile indices
	var HORI = 2
	var DR = 1
	var DL = 7
	var UR = 11
	var UL = 12
	var VERT = 6
	# u r d l
	var mapping = {
		"0000" : HORI,
		"0001" : HORI,
		"0010" : VERT,
		"0011" : DL,
		"0100" : HORI,
		"0101" : HORI,
		"0110" : DR,
		"0111" : HORI,
		"1000" : VERT,
		"1001" : UL,
		"1010" : VERT,
		"1011" : VERT,
		"1100" : UR,
		"1101" : HORI,
		"1110" : VERT,
		"1111" : VERT
	}
	
	# pos, tile
	var diff = []
	
	for tile_pos in tilemap.get_used_cells():
		var tile_id = tilemap.get_cellv(tile_pos)
		printraw(tile_pos, tile_id, " ")
		if tile_id == HORI:
			var map_str = bool_to_bin_str(tilemap.get_cellv(tile_pos + Vector2(0 , -1)) == HORI) + \
					bool_to_bin_str(tilemap.get_cellv(tile_pos + Vector2(1 , 0 )) == HORI) + \
					bool_to_bin_str(tilemap.get_cellv(tile_pos + Vector2(0 , 1 )) == HORI) + \
					bool_to_bin_str(tilemap.get_cellv(tile_pos + Vector2(-1, 0 )) == HORI)
			
			print("MAP STR: ", tile_pos, map_str)
			
			diff.append([tile_pos, mapping[map_str]])
			
	for change in diff:
		tilemap.set_cellv(change[0], change[1])
	
func bool_to_bin_str(b):
	return "1" if b else "0"

func _ready():
	loadMap("1")
	
	fixWalls()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()