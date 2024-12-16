class_name QuestionButton
extends Button



var question: Question

var question_number: int:
	get:
		return get_index()

var points: int:
	get:
		return question_number + 1




func _ready() -> void:
	text = str(points)
	if  visible:
		CategoryMenu.remaining_questions += 1



func _on_pressed() -> void:
	CategoryMenu.remaining_questions -= 1
	print(question)
	print("REMAINING QUESTIONS: ", CategoryMenu.remaining_questions)
	QuestionManager.open_question(question, points)
	disabled = true
