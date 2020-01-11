extends TextureRect

var elapsed = Global.LAST_TIME

func _process(delta):
	elapsed += delta
	material.set_shader_param("offset", elapsed / 10)
	Global.LAST_TIME = elapsed