extends Panel

export(NodePath) var shadow
export(NodePath) var restartButton
var expanding = false

func _ready():
	get_node(restartButton).visible = false

func show_restart():
	get_node(restartButton).visible = true

func _process(delta):
	if expanding:
		rect_scale.y += 0.01
		get_node(shadow).rect_scale = rect_scale
		if rect_scale.y >= 2.7:
			expanding = false
			show_restart()

func _on_Timer_timeout():
	expanding = true
