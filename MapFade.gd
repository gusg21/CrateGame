extends Node2D

export var startVisible = true

func _ready():
	modulate.a = 1 if startVisible else 0

func fadeIn():
	$Tween.interpolate_property(self, "modulate:a", 0, 1, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func fadeOut():
	$Tween.interpolate_property(self, "modulate:a", 1, 0, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()