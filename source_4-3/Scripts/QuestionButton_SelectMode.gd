class_name QuestionButton_SelectMode
extends QuestionButton


@export var icon_check: Texture2D
@export var icon_x: Texture2D
@export var icon_box: Texture2D


func set_icon():
	if  SaveManager.progress.questions_seen.has(question.resource_path):
		icon = icon_check if SaveManager.progress.questions_seen[question.resource_path] else icon_x
	else:
		icon = icon_box


func _on_pressed() -> void:
	QuestionSelectMenu.current_button = self
	super()
	
func _on_answer_data_cleared():
	set_icon()
