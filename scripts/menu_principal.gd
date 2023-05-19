extends Control

const CREATOR_INSTAGRAM_URL = "https://www.instagram.com/ramirestech.games/"
const CREATOR_LINKEDIN_URL = "https://www.linkedin.com/in/guilherme-ramires-4480a0160/"


@onready var start_button: TextureButton = $MarginContainer/VBoxContainer/StartButton
@onready var quit_button: TextureButton = $MarginContainer/VBoxContainer/QuitButton
@onready var transition: Transition = $Transition
@onready var button_sounds: AudioStreamPlayer2D = $ButtonSounds

func _ready() -> void:
	MusicPlayer.play_random_music()


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_start_button_button_up() -> void:
	button_sounds.play()
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Game.PLAYER_REGISTER_SCREEN)


func _on_instagram_button_up() -> void:
	OS.shell_open(CREATOR_INSTAGRAM_URL)


func _on_linkedin_button_up() -> void:
	OS.shell_open(CREATOR_LINKEDIN_URL)
