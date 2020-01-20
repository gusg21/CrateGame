extends Camera2D

var focus_on_map = false

func gotoMapSelect():
	$Tween.interpolate_property(self, "position", Vector2.ZERO, \
	 Vector2(256, 0), 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$"/root/Menu/Map Select".fadeIn()
	focus_on_map = true

func gotoMainMenu():
	$Tween.interpolate_property(self, "position", Vector2(256, 0), \
	 Vector2.ZERO, 1, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()
	
	$"/root/Menu/Main".fadeIn()
	focus_on_map = false

func _on_Tween_tween_all_completed():
	if focus_on_map:
		$"/root/Menu/Main".fadeOut()
	else:
		$"/root/Menu/Map Select".fadeOut()