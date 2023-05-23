extends Node2D

const WINNER_COLOR: Color = Color.GREEN
const LOSER_COLOR: Color = Color.RED
const NORMAL_COLOR: Color = Color.WHITE
const TIE_SOUND: AudioStream = preload("res://assets/sounds/effects/empate.wav")
const WIN_SOUND: AudioStream = preload("res://assets/sounds/effects/sucess.mp3")
const VICTORY_SOUND: AudioStream = preload("res://assets/sounds/effects/game-win.mp3")
const BUTTON_SOUNDS: AudioStream = preload("res://assets/sounds/effects/UI Soundpack/OGG/Modern3.ogg")

@onready var board: Board = %Board
@onready var player_one_name: Label = $MarginContainer/HBoxContainer/Player1/NamePlayer
@onready var player_one_score: Label = $MarginContainer/HBoxContainer/Player1/ScorePlayer
@onready var player_two_name: Label = $MarginContainer/HBoxContainer/Player2/NamePlayer
@onready var player_two_score: Label = $MarginContainer/HBoxContainer/Player2/ScorePlayer
@onready var info_label: Label = %InformerLabel
@onready var transition: Transition = $Transition
@onready var background: RandomBackground = $BG
@onready var sounds_player: AudioStreamPlayer2D = $Sounds
@onready var replay_cover: ColorRect = %ReplayCover
@onready var result_label: Label = %ResultLabel
@onready var replay_button: TextureButton = %ReplayButton
@onready var main_menu_button: TextureButton = %MainMenuButton
@onready var music_tag: MusicTag = %MusicTag


func _ready() -> void:
	MusicPlayer.play_random_music()
	board.end_turn.connect(__change_turn)
	board.have_a_tie.connect(__have_a_tie)
	board.have_a_winner.connect(__have_a_winner)
	player_one_name.text = Game.players[Game.cell_state.X].player_name
	player_two_name.text = Game.players[Game.cell_state.CIRCLE].player_name


func _process(_delta: float) -> void:
	player_one_score.text = str(Game.players[Game.cell_state.X].score)
	player_two_score.text = str(Game.players[Game.cell_state.CIRCLE].score)

	if Game.player_in_turn == Game.cell_state.X:
		player_one_name.modulate = WINNER_COLOR
		player_two_name.modulate = NORMAL_COLOR
	elif Game.player_in_turn == Game.cell_state.CIRCLE:
		player_one_name.modulate = NORMAL_COLOR
		player_two_name.modulate = WINNER_COLOR

func __change_turn() -> void:
	Game.change_player_in_turn()


func __have_a_tie():
	board.block_all()
	info_label.text = "Empate"
	info_label.modulate = LOSER_COLOR
	music_tag.hide()
	info_label.show()
	__play_sound(TIE_SOUND)
	Game.score_tie()
	check_game_over()

func __have_a_winner(winner: Game.cell_state) -> void:
	board.block_all()
	info_label.text = Game.players[winner].player_name + "  venceu essa partida!"
	info_label.modulate = WINNER_COLOR
	music_tag.hide()
	info_label.show()
	__play_sound(WIN_SOUND)
	Game.score_player_with_state(winner)
	check_game_over()

func check_game_over() -> void:
	await get_tree().create_timer(2).timeout
	for player in Game.players.values():
		if player.score >= Game.SCORE_TO_WINN_THE_GAME:
			game_over()
			return
	end_of_match()

func game_over() -> void:
	var score1 = Game.players[Game.cell_state.X].score
	var score2 = Game.players[Game.cell_state.CIRCLE].score

	result_label.modulate = WINNER_COLOR

	var text_to_show = ""
	if score1 == score2:
		text_to_show = "O jogo terminou empatado, parabens aos competidores!"
	elif score1 > score2:
		text_to_show = Game.players[Game.cell_state.X].player_name + "  é o grande Campeão! Parabens!"
	else:
		text_to_show = Game.players[Game.cell_state.CIRCLE].player_name + "  é o grande Campeão! Parabens!"
	result_label.text = text_to_show

	replay_cover.show()

	Game.players[Game.cell_state.X].score = 0
	Game.players[Game.cell_state.CIRCLE].score = 0

	__play_sound(VICTORY_SOUND)


func end_of_match() -> void:
	info_label.hide()
	music_tag.show()
	board.clear_all()
	background.select_a_random_image()

func __play_sound(sound: AudioStream) -> void:
	sounds_player.stream = sound
	sounds_player.play()

func __buttons_default_actions() -> void:
	sounds_player.stream = BUTTON_SOUNDS
	sounds_player.play()
	transition.play_in()
	await transition.animation.animation_finished
	MusicPlayer.play_random_music()
	replay_cover.hide()


func _on_replay_button_mouse_entered() -> void:
	replay_button.modulate = WINNER_COLOR


func _on_replay_button_mouse_exited() -> void:
	replay_button.modulate = NORMAL_COLOR


func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.modulate = WINNER_COLOR


func _on_main_menu_button_mouse_exited() -> void:
	main_menu_button.modulate = NORMAL_COLOR


func _on_replay_button_pressed() -> void:
	__buttons_default_actions()
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	__buttons_default_actions()
	get_tree().change_scene_to_file(Game.MAIN_MENU)
