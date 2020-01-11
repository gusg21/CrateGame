extends Camera2D

var t_zoom

func _physics_process(delta):
	var map = get_parent().get_node("Map")
	var player1 = map.get_node("Player1")
	var player2 = map.get_node("Player2")
	
#	var map = (get_node(tilemap) as TileMap)
#	limit_left = map.get_used_rect().position.x * map.cell_size.x
#	limit_top = map.get_used_rect().position.y * map.cell_size.y
#	limit_right = map.get_used_rect().end.x * map.cell_size.x
#	limit_bottom = map.get_used_rect().end.y * map.cell_size.y
	
	var pos1 = player1.position
	var pos2 = player2.position
	var target = (pos1 + pos2) / 2 # avg
	
	var dist = pos1.distance_to(pos2)
	
	t_zoom = clamp(dist / 300, 0.25, 0.5)
	
	zoom.x = lerp(zoom.x, t_zoom, 0.01)
	zoom.y = zoom.x
	
	position = lerp(target, position, 0.1)