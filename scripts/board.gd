extends GridContainer
class_name Board

signal have_a_winner(winner: Game.cell_state)
signal have_a_tie
signal end_turn

var cells = []

func _ready() -> void:
	for cell in get_children():
		cell.selected.connect(end_of_turn)
		cells.append(cell)


func end_of_turn() -> void:
	var state_of_winner = __check_for_a_winner()

	if state_of_winner == Game.cell_state.EMPTY:
		var its_a_tie = __check_for_a_tie()

		if its_a_tie:
			__have_a_tie()
	else:
		__have_a_winner(state_of_winner)

	end_turn.emit()


func __check_for_a_winner() -> Game.cell_state:
	var winning_combinations = [
		[0, 1, 2], [3, 4, 5], [6, 7, 8],  # Linhas
		[0, 3, 6], [1, 4, 7], [2, 5, 8],  # Colunas
		[0, 4, 8], [2, 4, 6]              # Diagonais
	]

	for combination in winning_combinations:
		var cell0 = cells[combination[0]]
		var cell1 = cells[combination[1]]
		var cell2 = cells[combination[2]]

		if cell0.is_selected and cell1.is_selected and cell2.is_selected:
			if cell0.state == cell1.state and cell1.state == cell2.state:
				cell0.show_win()
				cell1.show_win()
				cell2.show_win()
				return cell0.state

	return Game.cell_state.EMPTY

func __check_for_a_tie() -> bool:
	for cell in cells:
		if not cell.is_selected:
			return false
	return true

func __have_a_tie() -> void:
	for cell in cells:
		cell.show_lose()
	have_a_tie.emit()

func __have_a_winner(winner: Game.cell_state) -> void:
	have_a_winner.emit(winner)

func clear_all() -> void:
	for cell in cells:
		cell.clear()

func block_all() -> void:
	for cell in cells:
		cell.is_selected = true
