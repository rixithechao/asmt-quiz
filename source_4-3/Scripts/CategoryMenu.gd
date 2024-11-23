class_name CategoryMenu
extends Control


const REQUIRED_SCORE: float = 20
static var score: float = 0
static var instance: CategoryMenu


@export var prompt_label: Label
@export var points_label: Label
@export var page_transform: Control
@export var player_opens: AnimationPlayer
@export var player_closes: AnimationPlayer


func _ready() -> void:
	instance = self
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

static func transition_close():
	instance.prompt_label.next()
	var trs = Array(instance.player_closes.get_animation_list())
	var result: String = "RESET"
	while (result == "RESET"):
		result = trs.pick_random()
	print(result)
	instance.player_closes.play(result)
