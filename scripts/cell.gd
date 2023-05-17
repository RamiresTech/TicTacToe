extends TextureButton
class_name Cell


@onready var mark: TextureRect = $mark

signal selected

const WINNER_COLOR: Color = Color.GREEN
const LOSER_COLOR: Color = Color.RED
const NORMAL_COLOR: Color = Color.WHITE
const HOVER_COLOR: Color = Color(Color.WHITE, 0.5)

var is_selected: bool = false
var state: Game.cell_state = Game.cell_state.EMPTY
var mark_textures: Dictionary = {
	Game.cell_state.X: preload("res://assets/images/X.png"),
	Game.cell_state.CIRCLE: preload("res://assets/images/circle.png")
}

func show_win() -> void:
	modulate = HOVER_COLOR
	mark.modulate = WINNER_COLOR

func show_lose() -> void:
	modulate = HOVER_COLOR
	mark.modulate = LOSER_COLOR

func clear() -> void:
	modulate = NORMAL_COLOR
	mark.modulate = NORMAL_COLOR
	mark.texture = null
	is_selected = false
	state = Game.cell_state.EMPTY


func _on_mouse_entered() -> void:
	if not is_selected:
		modulate = HOVER_COLOR


func _on_mouse_exited() -> void:
	if not is_selected:
		modulate = NORMAL_COLOR


func _on_button_up() -> void:
	if not is_selected:
		is_selected = true
		var player_who_selected = Game.player_in_turn
		state = player_who_selected
		mark.texture = mark_textures[player_who_selected]
		selected.emit()
