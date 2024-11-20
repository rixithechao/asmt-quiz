class_name QuestionPage
extends PanelContainer


@export_group("Node References")
@export var question_label: Label
@export var author_label: Label

var question: Question



func setup(q: Question):
	question = q
	question_label.text = question.text
	author_label.text = question.author

func give_answer(answer: Variant):
	pass
