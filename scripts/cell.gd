extends TextureButton
class_name Cell


@onready var mark: TextureRect = $mark

signal selected

const WINNER_COLOR: Color = Color.GREEN
const LOSER_COLOR: Color = Color.RED
const MARK_COLOR: Color = Color.BLACK
const NORMAL_COLOR: Color = Color.WHITE

@onready var audio: AudioStreamPlayer2D = $Sounds

var is_selected: bool = false
var state: Game.cell_state = Game.cell_state.EMPTY
var mark_textures: Dictionary = {
	Game.cell_state.X: preload("res://assets/images/X.png"),
	Game.cell_state.CIRCLE: preload("res://assets/images/circle.png")
}
var sounds: Dictionary = {
	Game.cell_state.CIRCLE: preload("res://assets/sounds/effects/UI Soundpack/OGG/Minimalist7.ogg"),
	Game.cell_state.X: preload("res://assets/sounds/effects/UI Soundpack/OGG/Minimalist9.ogg")
}

func show_win() -> void:
	modulate = NORMAL_COLOR
	mark.modulate = WINNER_COLOR

func show_lose() -> void:
	modulate = NORMAL_COLOR
	mark.modulate = LOSER_COLOR

func clear() -> void:
	mark.modulate = MARK_COLOR
	mark.texture = null
	is_selected = false
	state = Game.cell_state.EMPTY


func _on_button_up() -> void:
	if not is_selected:
		is_selected = true
		var player_who_selected = Game.player_in_turn
		state = player_who_selected
		audio.stream = sounds[player_who_selected]
		audio.play()
		mark.texture = mark_textures[player_who_selected]
		mark.modulate = MARK_COLOR
		selected.emit()
