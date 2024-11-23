class_name QuestionButton
extends Button



var question: Question

var question_number: int:
	get:
		return get_index()-2

var points: int:
	get:
		return question_number + 1



func _ready() -> void:
	text = str(points)



func _on_pressed() -> void:
	QuestionManager.open_question(question, points)
	disabled = true
