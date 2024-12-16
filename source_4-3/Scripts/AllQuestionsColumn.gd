class_name AllQuestionsColumn
extends MarginContainer

@export_group("Prefab References")
@export var button_prefab: PackedScene
@export var icon_check: Texture2D
@export var icon_x: Texture2D
@export var icon_box: Texture2D

@export_group("Node References")
@export var title_label: Label
@export var buttons_parent: Control


func add_button(number_text: String, q: Question):
	var new_b = button_prefab.instantiate() as QuestionButton
	buttons_parent.add_child(new_b)
	new_b.text = number_text + " (" + q.author + ")"
	if  SaveManager.progress.questions_seen.has(q.resource_path):
		new_b.icon = icon_check if SaveManager.progress.questions_seen[q.resource_path] else icon_x
	else:
		new_b.icon = icon_box

func populate(category: QuestionCategory):
	title_label.text = category.name
	for  i in category.questions.size():
		var q = category.questions[i]
		if  q is QuestionVariantSet:
			for  j in q.variants.size():
				var q2 = q.variants[j]
				add_button(str(i+1)+"-"+str(j+1), q2)
		else:
			add_button(str(i+1), q)
