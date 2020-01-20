extends Panel

func create(_name, description, isUser):
	$"Map Name".text = _name
	$"Map Description".bbcode_text = description
	$"DLC?".visible = isUser