extends Node2D

var elapsed = Global.LAST_TIME

func _process(delta):
	elapsed += delta
	($Background.material as ShaderMaterial).set_shader_param("offset", elapsed / 10)

func _exit_tree():
	Global.LAST_TIME = elapsed