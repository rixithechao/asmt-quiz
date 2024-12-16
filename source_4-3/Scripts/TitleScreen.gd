class_name TitleScreen
extends Control


@export var title_tex: TextureRect
@export var bg_cover: ColorRect
@export var about_popup: AcceptDialog
@export var question_select: Button
@export var version_label: Label


func _ready() -> void:
	question_select.visible = SaveManager.progress.free_mode_unlocked
	version_label.text = "v"+ProjectSettings.get_setting("application/config/version")


func _process(_delta: float) -> void:
	title_tex.rotation_degrees = 4*sin(deg_to_rad(
0.1*Time.get_ticks_msec()))


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene_Main.tscn")

func _on_about_pressed() -> void:
	about_popup.visible = true
	bg_cover.visible = true

func _on_settings_pressed() -> void:
	pass # Replace with function body.

func _on_question_select_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene_QuestionSelect.tscn")
	#SaveManager.progress.questions_seen[q.resource_path]

func _on_quit_pressed() -> void:
	get_tree().quit()




func _on_about_confirmed() -> void:
	about_popup.visible = false
	bg_cover.visible = false
