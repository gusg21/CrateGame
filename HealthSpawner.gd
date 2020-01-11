extends Node2D

const HEALTH_SCENE = preload("res://Health.tscn")
const BOOST_SCENE = preload("res://Boost.tscn")
export(NodePath) var healthSound
var last_rand_index = -1

func _ready():
	randomize()

func _on_Spawn_New_timeout():
	var rand_index = randi() % get_child_count()
	while rand_index == last_rand_index:
		rand_index = randi() % get_child_count()
	last_rand_index = rand_index
	
	var collectible
	match randi() % 2:
		0:	collectible = HEALTH_SCENE.instance()
		1: 	collectible = BOOST_SCENE.instance()
	
	collectible.healthSound = NodePath("../../../HealthSound")
	collectible.position = get_children()[rand_index].position + Vector2(rand_range(-10, 10), rand_range(-10, 10))
	
	add_child(collectible)
	
	get_node(healthSound).play()