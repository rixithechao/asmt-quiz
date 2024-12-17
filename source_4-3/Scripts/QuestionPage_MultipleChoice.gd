class_name QuestionPage_MultipleChoice
extends QuestionPage


const NUMBER_CHOICES: int = 4


@export var choice_buttons: Array[Button]


var correctness: Array[bool] = []
var selected: int = -1
static var style_correct : StyleBoxFlat = preload("res://Style_DisabledButton_Correct.tres")
static var style_wrong : StyleBoxFlat = preload("res://Style_DisabledButton_Wrong.tres")


func extra_setup(q: Question):
	var q_mc = q as Question_MultipleChoice
	var num_correct = min(q.minimum_right_answers, q.right_answers.size(), NUMBER_CHOICES)
	
	for i in NUMBER_CHOICES:
		correctness.append(true if i<num_correct else false)
	correctness.shuffle()

	var right_index: int = 0
	var wrong_index: int = 0
	var right_answers: Array[String] = q_mc.right_answers.duplicate()
	var wrong_answers: Array[String] = q_mc.wrong_answers.duplicate()
	if  q_mc.right_answers.size() > 0:
		right_answers.shuffle()
	if  q_mc.wrong_answers.size() > 0:
		wrong_answers.shuffle()

	for i in NUMBER_CHOICES:
		var button_text = ""
		if  correctness[i]:
			button_text = right_answers[min(right_index, right_answers.size()-1)]
			right_index += 1
		else:
			button_text = wrong_answers[min(wrong_index, wrong_answers.size()-1)]
			wrong_index += 1
		choice_buttons[i].text = button_text
		var text_size = 1
		if  q_mc.answer_sizes.has(button_text):
			text_size = q_mc.answer_sizes[button_text]
			choice_buttons[i].add_theme_font_size_override("font_size",32*text_size)


func give_answer(answer: Variant):
	selected = answer
	if  correctness.size() > answer and correctness[answer] == true:
		show_results(true)
	else:
		show_results(false)


func show_results(was_correct: bool):
	super(was_correct)

	var selected_text = choice_buttons[selected].text

	if  image_rect.visible  and  question.specific_answer_images.has(selected_text):
		image_rect.texture = question.specific_answer_images[selected_text]

	for i in NUMBER_CHOICES:
		var btn = choice_buttons[i]
		btn.disabled = true

		if  correctness[i]:
			btn.add_theme_stylebox_override ("disabled", style_correct)
		elif  not was_correct  and  (i == selected  or  time_expired):
			btn.add_theme_stylebox_override ("disabled", style_wrong)


func _on_choice_a_pressed() -> void:
	give_answer(0)
func _on_choice_b_pressed() -> void:
	give_answer(1)
func _on_choice_c_pressed() -> void:
	give_answer(2)
func _on_choice_d_pressed() -> void:
	give_answer(3)
