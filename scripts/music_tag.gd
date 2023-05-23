extends Control
class_name MusicTag


@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var music_name_label: Label = $Button/MarginContainer/HBoxContainer/Label
@onready var next_button: TextureButton = $Button/MarginContainer/HBoxContainer/NextButton

var is_closed: bool = true


func _process(_delta: float) -> void:
	music_name_label.text = "Ouvindo: " + MusicPlayer.actual_music


func _on_button_button_up() -> void:
	if is_closed:
		animation.play("open")
		is_closed = false
	else:
		animation.play("close")
		is_closed = true


func _on_next_button_button_up() -> void:
	MusicPlayer.play_random_music()


func _on_next_button_mouse_entered() -> void:
	next_button.modulate = Color(Color.WHITE)


func _on_next_button_mouse_exited() -> void:
	next_button.modulate = Color(Color.BLACK)
