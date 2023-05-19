extends Control


@onready var player_one_name: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/LineEdit
@onready var player_two_name: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer2/LineEdit
@onready var play_button: TextureButton = $MarginContainer/PlayButton
@onready var transition: Transition = $Transition
@onready var button_sounds: AudioStreamPlayer2D = $ButtonSounds



func _on_play_button_button_up() -> void:
	var player_one = Player.new(player_one_name.text)
	var player_two = Player.new(player_two_name.text)

	var players: Dictionary = {
		Game.cell_state.X: player_one,
		Game.cell_state.CIRCLE: player_two
	}

	Game.players = players

	button_sounds.play()
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Game.MATCH_SCREEN)
