extends Node

const WINNER_SCORE_INCRESS: int = 300
const TIE_SCORE_INCRESS: int = 100
const SCORE_TO_WINN_THE_GAME: int = 1500
# Scenes Path
const PLAYER_REGISTER_SCREEN: String = "res://scenes/players_register.tscn"
const MAIN_MENU: String = "res://scenes/menu_principal.tscn"
const MATCH_SCREEN: String = "res://scenes/match.tscn"

enum cell_state{
	X,
	CIRCLE,
	EMPTY
	}


var players: Dictionary = {}

var player_in_turn: cell_state = cell_state.X


func change_player_in_turn():
	if player_in_turn == cell_state.X:
		player_in_turn = cell_state.CIRCLE
	else:
		player_in_turn = cell_state.X

func score_player_with_state(state: cell_state):
	players[state].score += WINNER_SCORE_INCRESS

func score_tie():
	players[cell_state.X].score += TIE_SCORE_INCRESS
	players[cell_state.CIRCLE].score += TIE_SCORE_INCRESS
