class_name SplashScreens
extends Control


@export var sequence_player: AnimationPlayer

var started: bool = false


func to_title():
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")


func _ready() -> void:
	var rec_check = SaveManager.settings.recording_check
	if  rec_check == 2  or  (rec_check == 1 and false):
		$RecordButton.visible = false
		started = true
		sequence_player.play("Intro_2")


func _on_record_button_pressed() -> void:
	if  not started:
		started = true
		sequence_player.play("Intro")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if  anim_name == "Intro":
		sequence_player.play("Intro_2")
