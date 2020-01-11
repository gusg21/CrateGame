extends Panel

export(NodePath) var shadow 


func _process(delta):
	get_node(shadow).rect_size = rect_size