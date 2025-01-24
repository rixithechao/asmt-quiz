class_name AllQuestionsColumn
extends MarginContainer

@export_group("Prefab References")
@export var button_prefab: PackedScene

@export_group("Node References")
@export var title_label: Label
@export var buttons_parent: Control


func add_button(number_text: String, q: Question):
	var new_b = button_prefab.instantiate() as QuestionButton_SelectMode
	buttons_parent.add_child(new_b)
	#if  q.author != "Rixitic":
	new_b.text = number_text + " (" + q.author + ")"
	#else:
	#	new_b.text = number_text
	new_b.question = q
	new_b.set_icon()
	new_b.disable_after_click = false
	QuestionSelectMenu.instance.cleared_answer_data.connect(new_b._on_answer_data_cleared)
	QuestionSelectMenu.total_questions += 1

func populate(category: QuestionCategory):
	title_label.text = category.name
	for  i in category.questions.size():
		var q = category.questions[i]
		if  q is QuestionVariantSet:
			for  j in q.variants.size():
				var q2 = q.variants[j]
				add_button(str(i+1)+"-"+String.chr(65+j), q2)
		else:
			add_button(str(i+1), q)
