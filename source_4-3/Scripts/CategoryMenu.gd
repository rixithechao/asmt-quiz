class_name CategoryMenu
extends Control


const REQUIRED_SCORE: float = 20
static var score: float = 0
static var remaining_questions: int = 0
static var instance: CategoryMenu

@export var prompt_label: RandomizedLabel
@export var points_label: Label
@export var page_transform: Control
@export var player_opens: AnimationPlayer
@export var player_closes: AnimationPlayer
@export var block_mouse_rect: ColorRect
@export var bg_cover_rect: ColorRect
@export var exit_dialog: ConfirmationDialog
@export var debug_button: Button


func _ready() -> void:
	instance = self
	prompt_label.next()
	set_score(0)


static func change_score(amount: float):
	set_score(score+amount)

static func set_score(val: float):
	score = val
	instance.points_label.text = str(score)+"/"+str(REQUIRED_SCORE)


static func transition_reset():
	instance.player_opens.play("RESET")

static func transition_open():
	var trs = Array(instance.player_opens.get_animation_list())
	var result: String = "RESET"
	while (result == "RESET"):
		result = trs.pick_random()
	print(result)
	instance.player_opens.play(result)
	instance.block_mouse_rect.visible = true
	
	await instance.player_opens.animation_finished

static func transition_close():
	instance.prompt_label.next()
	var trs = Array(instance.player_closes.get_animation_list())
	var result: String = "RESET"
	while (result == "RESET"):
		result = trs.pick_random()
	print(result)
	instance.player_closes.play(result)

	await instance.player_closes.animation_finished
	instance.block_mouse_rect.visible = false
	transition_reset()



func _on_exit_pressed() -> void:
	exit_dialog.visible = true
	bg_cover_rect.visible = true

func _on_exit_confirm_confirmed() -> void:
	remaining_questions = 0
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")

func _on_exit_confirm_canceled() -> void:
	exit_dialog.visible = false
	bg_cover_rect.visible = false


func _on_debug_pressed() -> void:
	remaining_questions = 1
	debug_button.disabled = true
