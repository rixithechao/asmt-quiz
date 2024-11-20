class_name QuestionColumn
extends MarginContainer


@export var category_group: CategoryGroup

@export_group("Node References")
@export var title_label: Label
@export var buttons_parent: Control


var questions: Array[Question]

var _category: QuestionCategory
var category: QuestionCategory:
	get:
		if  _category == null:
			_category = category_group.categories.pick_random()
		return _category


func _ready() -> void:
	title_label.text = category.name
	questions = category.select_questions()
	for child in buttons_parent.get_children():
		if  child is QuestionButton:
			child.question = questions[child.question_number]
