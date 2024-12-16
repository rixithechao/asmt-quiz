class_name SplashScreens
extends Control


@export var sequence_player: AnimationPlayer

var started: bool = false


func to_title():
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")


func _on_record_button_pressed() -> void:
	if  not started:
		started = true
		sequence_player.play("Intro")
