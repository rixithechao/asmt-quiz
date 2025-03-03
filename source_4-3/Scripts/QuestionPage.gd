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
@export var correct_sound: AudioStreamPlayer
@export var wrong_sound: AudioStreamPlayer
@export var confetti_emitters: Array[GPUParticles2D]
@export var time_challenge_music: AudioStreamPlayer

var question: Question
var points: int
var time_expired: bool = false
var timer_started: bool = false

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
		timer_bar.value = timer_bar.max_value
		timer_node.wait_time = question.seconds+1
	else:
		timer_row.visible = false

	extra_setup(q)
	await CategoryMenu.instance.player_opens.animation_finished

	if  question.seconds > 0:
		MusicManager.pause()
		timer_started = true
		timer_animation.play("TimerStart")


func extra_setup(_q: Question):
	pass


func give_answer(_answer: Variant):
	pass


func show_results(was_correct: bool):
	if  question.seconds > 0:
		time_challenge_music.stop()

	if  GameplayScene.instance is CategoryMenu  and  CategoryMenu.remaining_questions <= 0:
		MusicManager.fade_out()
	
	if  was_correct:
		SaveManager.progress.questions_seen[question.resource_path] = true
		SaveManager.progress.save()
	prompt_node.visible = false
	timer_node.paused = true
	if  image_rect.visible  and  question.image_answered != null:
		image_rect.texture = question.image_answered
	
	if  was_correct:
		if  randf() <= 0.4:
			for em:GPUParticles2D in confetti_emitters:
				em.emitting = true
		correct_sound.play()
		correct_node.visible = true
		if  GameplayScene.instance is CategoryMenu:
			CategoryMenu.change_score(points)
	else:
		wrong_sound.play()
		if  not time_up_node.visible:
			wrong_node.visible = true
		if  GameplayScene.instance is CategoryMenu:
			CategoryMenu.change_score(0)
	back_button.visible = true


func close():
	if  question.sound != null  or  question.seconds > 0:
		MusicManager.unpause()

	if  GameplayScene.instance is CategoryMenu  and  CategoryMenu.remaining_questions <= 0:
		GameplayScene.instance.scene_transition_overlay.transition_out()
		await GameplayScene.instance.scene_transition_overlay.finished
		get_tree().change_scene_to_file("res://Scenes/Scene_Results.tscn")
	else:
		GameplayScene.instance.transition_close()
		await GameplayScene.instance.player_closes.animation_finished
		queue_free()




func _process(_delta: float) -> void:
	if  question.seconds > 0  and  timer_started:
		if  not timer_node.is_stopped():
			timer_bar.value = timer_node.time_left
		else:
			pass


func _on_timer_timeout() -> void:
	timer_row.visible = false
	time_up_node.visible = true
	time_expired = true
	show_results(false)

func _on_back_button_pressed() -> void:
	close()

func _on_timer_animation_animation_finished(_anim_name: StringName) -> void:
	timer_node.start()
