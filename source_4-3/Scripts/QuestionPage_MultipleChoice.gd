class_name QuestionPage_MultipleChoice
extends QuestionPage


const NUMBER_CHOICES: int = 4


@export var choice_buttons: Array[Button]


var correctness: Array[bool]


func setup(q: Question):
	super(q)
	
	var q_mc = q as Question_MultipleChoice
	var num_correct = min(q.right_answers.size(), NUMBER_CHOICES)
	
	for i in NUMBER_CHOICES:
		correctness.append(true if i<num_correct else false)
	correctness.shuffle()

	var right_index: int = 0
	var wrong_index: int = 0
	var right_answers = q_mc.right_answers.duplicate().shuffle()
	var wrong_answers = q_mc.wrong_answers.duplicate().shuffle()

	for i in NUMBER_CHOICES:
		var button_text = ""
		if  correctness[i]:
			button_text = right_answers[right_index]
			right_index += 1
		else:
			button_text = wrong_answers[wrong_index]
			wrong_index += 1
		choice_buttons[i].text = button_text


func give_answer(answer: Variant):
	if  correctness[answer]:
		pass
	else:
		pass


func _on_choice_a_pressed() -> void:
	give_answer(0)
func _on_choice_b_pressed() -> void:
	give_answer(1)
func _on_choice_c_pressed() -> void:
	give_answer(2)
func _on_choice_d_pressed() -> void:
	give_answer(3)
