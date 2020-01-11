extends Label

const STRINGS = [
	"sine ludo greges",
	"Blendercult, 2020",
	"Nicholas checked out a book.",
	"LG: Life's Good.",
	"Fonky Chonky"
]

func reshuffle():
	text = STRINGS[randi() % STRINGS.size() - 1]

func _ready():
	randomize()
	reshuffle()
	
func _process(delta):
	if Input.is_action_just_pressed("player2_grapple"):
		reshuffle()
