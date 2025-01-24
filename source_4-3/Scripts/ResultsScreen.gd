class_name ResultsScreen
extends Control


@export var score_label: Label
@export var win_close_label: Label
@export var win_strong_label: Label
@export var lose_close_label: Label
@export var lose_strong_label: Label
@export var reveal_nodes: Array[Node]
@export var win_sound_player: AudioStreamPlayer
@export var lose_sound_player: AudioStreamPlayer
@export var popup_sound_player: AudioStreamPlayer
@export var return_button_sound_player: AudioStreamPlayer
@export var return_button: Button
@export var bg_cover: ColorRect
@export var free_mode_popup: PanelContainer
@export var sequence_animplayer: AnimationPlayer
@export var scene_transition_overlay: SceneTransitionOverlay


var won: bool = true
var showing_popup: bool = false
var rating_label: Label
var win_or_lose_player: AudioStreamPlayer

signal unlock_window_closed


func _ready():
	var req = CategoryMenu.REQUIRED_SCORE
	var score = CategoryMenu.score
	win_or_lose_player = win_sound_player
	
	if  score >= req + 10:
		rating_label = win_strong_label
	elif  score >= req:
		rating_label = win_close_label
	elif  score >= req*0.5:
		won = false
		win_or_lose_player = lose_sound_player
		rating_label = lose_close_label
	else:
		won = false
		win_or_lose_player = lose_sound_player
		rating_label = lose_strong_label
	
	rating_label.visible = true

	score_label.get_child(0).text = str(score) + "/" + str(req)

	if  not SaveManager.progress.free_mode_unlocked:
		SaveManager.progress.free_mode_unlocked = true
		showing_popup = true

	SaveManager.progress.high_score = max(SaveManager.progress.high_score, score)
	SaveManager.progress.save()


	# Start sequence
	sequence_animplayer.play("ResultsSequence")


func tween_item(i: int, is_rating: bool):
	var this_node = reveal_nodes[i]
	this_node.visible = true

	# Tween
	var tweened = this_node.get_child(0)
	var tween = self.create_tween()
	if  is_rating:
		tweened = rating_label.get_child(0)
		if  won:
			tweened.position.y = 30
			tween.tween_property(tweened, "position", Vector2.ZERO, 0.1).set_trans(Tween.TRANS_SPRING)
		else:
			tween.tween_property(tweened, "position", Vector2(0,40), 0.2).set_trans(Tween.TRANS_QUAD)
			tween.set_parallel()
			tween.tween_property(tweened, "rotation", deg_to_rad(4), 0.2).set_trans(Tween.TRANS_QUAD)
			
	else:
		tween.tween_property(tweened, "scale", Vector2.ONE, 0.1).set_trans(Tween.TRANS_SPRING)

func play_win_or_lose_sound():
	win_or_lose_player.play()



func popup_or_end():
	if  showing_popup:
		bg_cover.visible = true
		free_mode_popup.visible = true
		popup_sound_player.play()
	else:
		show_return_button()

func show_return_button():
	return_button_sound_player.play()
	return_button.visible = true


func _on_back_to_title_pressed() -> void:
	scene_transition_overlay.transition_out()
	await scene_transition_overlay.finished
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")


func _on_popup_button_pressed() -> void:
	free_mode_popup.visible = false
	bg_cover.visible = false
	sequence_animplayer.play("ResultsSequence2")
