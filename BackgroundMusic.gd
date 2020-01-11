extends AudioStreamPlayer

func _ready():
	$Tween.interpolate_property(self, "volume_db", -40, -7, 3, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	