class_name QuestionPage
extends PanelContainer


@export_group("Node References")
@export var question_label: Label
@export var author_label: Label
@export var prompt_node: VBoxContainer
@export var correct_node: VBoxContainer
@export var wrong_node: VBoxContainer
@export var back_button: Button

var question: Question
var points: int


func setup(q: Question):
	question = q
	question_label.text = question.text
	author_label.text = "Submitted by: "+question.author


func give_answer(answer: Variant):
	pass


func show_results(was_correct: bool):
	prompt_node.visible = false
	if  was_correct:
		correct_node.visible = true
		CategoryMenu.change_score(points)
	else:
		wrong_node.visible = true
		CategoryMenu.change_score(0)
	back_button.visible = true


func close():
	CategoryMenu.transition_close()
	await CategoryMenu.instance.player_closes.animation_finished
	queue_free()


func _on_back_button_pressed() -> void:
	close()
