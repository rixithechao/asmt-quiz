class_name QuestionSelectMenu
extends GameplayScene

@export var category_groups: Array[CategoryGroup]
@export var column_prefab: PackedScene
@export var column_container: FlowContainer
@export var answered_label: Label
@export var clear_confirm_dialog: ConfirmationDialog


static var current_button: QuestionButton_SelectMode
static var total_questions: int = 0


signal cleared_answer_data


func update_answered_label():
	var answered_questions = SaveManager.progress.questions_seen.keys().size()
	answered_label.text = str(answered_questions)+"/"+str(total_questions)+"\nAnswered"
	


func _ready() -> void:
	instance = self
	total_questions = 0
	for  g in category_groups:
		for c in g.categories:
			var col = column_prefab.instantiate()
			column_container.add_child(col)
			col.populate(c)
	update_answered_label()


static func transition_close():
	current_button.set_icon()
	instance.update_answered_label()
	super()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")


func _on_clear_button_pressed() -> void:
	clear_confirm_dialog.visible = true
	bg_cover_rect.visible = true

func _on_clear_confirm_confirmed() -> void:
	SaveManager.progress.questions_seen.clear()
	SaveManager.progress.save()
	instance.update_answered_label()
	clear_confirm_dialog.visible = false
	bg_cover_rect.visible = false
	cleared_answer_data.emit()
	
func _on_clear_confirm_canceled() -> void:
	clear_confirm_dialog.visible = false
	bg_cover_rect.visible = false
