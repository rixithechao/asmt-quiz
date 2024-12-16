class_name QuestionPage_Microgame
extends QuestionPage


enum WinState {NONE, LOST, WON}

@export var current_win_state: WinState


func _on_timer_timeout() -> void:
	timer_row.visible = false
	if  current_win_state == WinState.NONE  or  WinState.LOST:
		time_up_node.visible = true
		time_expired = true
		show_results(false)
	else:
		show_results(true)
