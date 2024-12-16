class_name ResultsScreen
extends Control


@export var score_label: Label
@export var win_close_label: Label
@export var win_strong_label: Label
@export var lose_close_label: Label
@export var lose_strong_label: Label
@export var reveal_timer: Timer
@export var reveal_nodes: Array[Node]
@export var reveal_times: Array[float]
@export var free_mode_dialog: AcceptDialog


func _ready():
	var req = CategoryMenu.REQUIRED_SCORE
	var score = CategoryMenu.score
	
	if  score >= req + 10:
		win_strong_label.visible = true
	elif  score >= req:
		win_close_label.visible = true
	elif  score >= req*0.5:
		lose_close_label.visible = true
	else:
		lose_strong_label.visible = true

	score_label.text = str(score) + "/" + str(req)

	if  not SaveManager.progress.free_mode_unlocked:
		SaveManager.progress.free_mode_unlocked = true
		reveal_nodes.insert(3,free_mode_dialog)
		reveal_times.insert(3,1)
		reveal_times[4] = 1

	SaveManager.progress.high_score = max(SaveManager.progress.high_score, score)
	SaveManager.progress.save()


	# Reveal sequence
	for i in reveal_nodes.size():
		reveal_timer.start(reveal_times[i])
		await reveal_timer.timeout
		
		var this_node = reveal_nodes[i]
		this_node.visible = true
		
		if  this_node is AcceptDialog:
			await this_node.confirmed


func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and event.pressed and not reveal_timer.is_stopped():
		reveal_timer.stop()

func _on_back_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")
