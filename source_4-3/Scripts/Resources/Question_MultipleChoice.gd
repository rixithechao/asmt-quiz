class_name Question_MultipleChoice
extends Question

@export var right_answers: Array[String]
@export var wrong_answers: Array[String]
@export var minimum_right_answers: int = 1

@export var answer_sizes: Dictionary
@export var highlight_all_correct: bool = true
