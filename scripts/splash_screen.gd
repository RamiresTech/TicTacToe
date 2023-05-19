extends Control


@onready var sounds_player: AudioStreamPlayer2D = $Sounds


func play_sound() -> void:
	sounds_player.play()

func go_to_menu() -> void:
	get_tree().change_scene_to_file(Game.MAIN_MENU)
