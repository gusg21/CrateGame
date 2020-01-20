extends Label

var visible_timer = -1
var shake_timer = -1
var init_position

func _ready():
	init_position = rect_position
	visible = false

func show():
	shake_timer = 20
	visible_timer = 240
	modulate.a = 1
	visible = true

func _physics_process(delta):
	if shake_timer > 0:
		rect_position = init_position + Vector2(rand_range(-2, 2), rand_range(-2, 2))
	else:
		rect_position = init_position
	
	shake_timer -= 1
	
	if visible_timer < 60:
		modulate.a = (visible_timer / 60.0)
	
	if visible_timer <= 0:
		visible = false
	
	visible_timer -= 1