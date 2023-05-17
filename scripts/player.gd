extends Node
class_name Player

var player_name: String = ""
var score: int = 0

func _init(name: String) -> void:
	player_name = name
