extends CanvasLayer
class_name Transition


@onready var transition: ColorRect = $Fill
@onready var animation: AnimationPlayer = $Fill/animation

enum transictions_types{Pixels, SpotPlayer, SpotCenter, VerticalCut, HorizontalCut}

@export var transiction_type: transictions_types
@export var duration: float = 1.0


func _ready() -> void:
	transition.material.set_shader_parameter("type", transiction_type)
	animation.speed_scale = duration

func play_in() -> void:
	show()
	animation.play("transiction_in")

func play_out() -> void:
	show()
	animation.play("transiction_out")


func _on_animation_animation_finished(_anim_name: StringName) -> void:
	hide()
