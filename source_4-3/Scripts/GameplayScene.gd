class_name GameplayScene
extends Control


static var instance: GameplayScene

@export var page_transform: Control
@export var player_opens: AnimationPlayer
@export var player_closes: AnimationPlayer
@export var block_mouse_rect: ColorRect
@export var bg_cover_rect: ColorRect


func _ready() -> void:
	instance = self


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
	var trs = Array(instance.player_closes.get_animation_list())
	var result: String = "RESET"
	while (result == "RESET"):
		result = trs.pick_random()
	print(result)
	instance.player_closes.play(result)

	await instance.player_closes.animation_finished
	instance.block_mouse_rect.visible = false
	transition_reset()
