class_name QuestionPage
extends PanelContainer


@export_group("Node References")
@export var question_label: Label
@export var author_label: Label
@export var prompt_node: VBoxContainer
@export var correct_node: VBoxContainer
@export var time_up_node: VBoxContainer
@export var wrong_node: VBoxContainer
@export var back_button: Button
@export var image_rect: TextureRect
@export var sound_button: SoundButton
@export var timer_row: HBoxContainer
@export var timer_node: Timer
@export var timer_bar: ProgressBar
@export var timer_animation: AnimationPlayer
@export var info_and_buttons_container: VBoxContainer

var question: Question
var points: int
var time_expired: bool = false

func setup(q: Question):
	if  not SaveManager.progress.questions_seen.has(q.resource_path): 
		SaveManager.progress.questions_seen[q.resource_path] = false
		SaveManager.progress.save()
	question = q
	question_label.text = question.text
	author_label.text = "Submitted by: "+question.author
	if  question.image != null:
		image_rect.visible = true
		image_rect.texture = question.image
	if  question.sound != null:
		sound_button.visible = true
		sound_button.player.stream = question.sound
		MusicManager.pause()

	if  CategoryMenu.remaining_questions <= 0:
		back_button.text = "Final Results"

	if  question.seconds > 0:
		info_and_buttons_container.visible = false
		timer_bar.max_value = question.seconds
		timer_node.wait_time = question.seconds+1
		timer_row.visible = true

	extra_setup(q)
	await CategoryMenu.instance.player_opens.animation_finished

	if  question.seconds > 0:
		timer_animation.play()


func extra_setup(_q: Question):
	pass


func give_answer(_answer: Variant):
	pass


func show_results(was_correct: bool):
	if  was_correct:
		SaveManager.progress.questions_seen[question.resource_path] = true
		SaveManager.progress.save()
	prompt_node.visible = false
	timer_node.paused = true
	if  image_rect.visible  and  question.image_answered != null:
		image_rect.texture = question.image_answered
	
	if  was_correct:
		correct_node.visible = true
		CategoryMenu.change_score(points)
	else:
		if  not time_up_node.visible:
			wrong_node.visible = true
		CategoryMenu.change_score(0)
	back_button.visible = true


func close():
	if  question.sound != null:
		MusicManager.unpause()

	if  CategoryMenu.remaining_questions > 0:
		CategoryMenu.transition_close()
		await CategoryMenu.instance.player_closes.animation_finished
		queue_free()
	else:
		get_tree().change_scene_to_file("res://Scenes/Scene_Results.tscn")



func _process(_delta: float) -> void:
	if  question.seconds > 0:
		timer_bar.value = timer_node.time_left


func _on_timer_timeout() -> void:
	timer_row.visible = false
	time_up_node.visible = true
	time_expired = true
	show_results(false)

func _on_back_button_pressed() -> void:
	close()

func _on_timer_animation_animation_finished(_anim_name: StringName) -> void:
	timer_node.start()
