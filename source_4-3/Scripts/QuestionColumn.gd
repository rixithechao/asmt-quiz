class_name QuestionColumn
extends MarginContainer


@export var potential_categories: Array[QuestionCategory]

@export_group("Node References")
@export var title_label: Label


var category: QuestionCategory:
	get:
		return QuestionManager.chosen_categories[get_index()]


func open_question(index: int):
	pass


func _on_question_1_pressed() -> void:
	open_question(1)
func _on_question_2_pressed() -> void:
	open_question(2)
func _on_question_3_pressed() -> void:
	open_question(3)
func _on_question_4_pressed() -> void:
	open_question(4)
func _on_question_5_pressed() -> void:
	open_question(5)
