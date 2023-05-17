extends Control


const NORMAL_COLOR: Color = Color.WHITE
const HOVER_COLOR: Color = Color(Color.WHITE, 0.5)


@onready var start_button: TextureButton = $MarginContainer/VBoxContainer/StartButton
@onready var quit_button: TextureButton = $MarginContainer/VBoxContainer/QuitButton
@onready var transition: Transition = $Transition


func _on_start_button_mouse_entered() -> void:
	start_button.modulate = HOVER_COLOR


func _on_start_button_mouse_exited() -> void:
	start_button.modulate = NORMAL_COLOR


func _on_quit_button_mouse_entered() -> void:
	quit_button.modulate = HOVER_COLOR


func _on_quit_button_mouse_exited() -> void:
	quit_button.modulate = NORMAL_COLOR


func _on_quit_button_button_up() -> void:
	get_tree().quit()


func _on_start_button_button_up() -> void:
	transition.play_in()
	await transition.animation.animation_finished
	get_tree().change_scene_to_file(Game.PLAYER_REGISTER_SCREEN)
