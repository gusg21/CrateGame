extends Sprite

const PLAYER_GRAPHICS = [preload("Assets/Characters/player1.png"), preload("Assets/Characters/player2.png")]

func _ready():
	set_texture(PLAYER_GRAPHICS[1 if Global.WINNER_P2 else 0])