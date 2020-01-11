extends Area2D

export(NodePath) var healthSound

var i_pos = Vector2.ZERO
var elapsed = 0

func _ready():
	i_pos = position

func _on_Area2D_body_entered(body):
	body.boosts = 5
	
	get_node(healthSound).play()
	queue_free()
	
func _physics_process(delta):
	elapsed += delta
	position = i_pos + Vector2(0, sin(elapsed * 10) * 3)
