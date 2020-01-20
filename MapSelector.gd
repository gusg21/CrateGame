extends Node2D

var availableMaps = []
var showingMap = 0

func list_files_in_directory(path):
    var files = []
    var dir = Directory.new()
    dir.open(path)
    dir.list_dir_begin()

    while true:
        var file = dir.get_next()
        if file == "":
            break
        elif not file.begins_with("."):
            files.append(path + "/" + file)

    dir.list_dir_end()

    return files

func assembleMaps():
	for path in list_files_in_directory("res://Assets/Maps"):
		if not path.ends_with("tscn"):
			continue
		
		var i = load(path).instance()
		
		if not i.has_node("Descriptor"):
			continue
		
		var desc = i.get_node("Descriptor")
		
		if desc.get("map_name") == null or desc.get("description") == null:
			continue
		
		availableMaps.append([
			path,
			desc.map_name,
			desc.description,
			false # is in user dir
		])
	
	var dir = Directory.new()
	if not dir.dir_exists("user://Maps"):
		dir.make_dir("user://Maps")
		
	for path in list_files_in_directory("user://Maps"):
		print("Found user map: " + path)
		
		var i = load(path).instance()
		
		availableMaps.append([
			path,
			i.get_node("Descriptor").map_name,
			i.get_node("Descriptor").description,
			true
		])
		
		if not path.ends_with("tscn"):
			continue
			
func get_selected_path():
	return availableMaps[showingMap][0]

func showMapId():
	$Display.create(availableMaps[showingMap][1], availableMaps[showingMap][2], availableMaps[showingMap][3])

func _ready():
	assembleMaps()
	
	print("Maps found: " + str(availableMaps))
	
	showMapId()

func _on_Shift_Left_pressed():
	showingMap -= 1
	showingMap %= len(availableMaps)
	showMapId()

func _on_Shift_Right_pressed():
	pass # Replace with function body.
