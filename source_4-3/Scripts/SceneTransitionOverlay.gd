class_name SceneTransitionOverlay
extends Control


@export var auto_start: bool = true
@export var mask_in: Texture2D
@export var mask_out: Texture2D
@export var sound_in: AudioStreamPlayer
@export var sound_out: AudioStreamPlayer


@export var cutoff: float = 1

signal finished


func transition(value: float, duration: float = 0.25):
	var tween = get_tree().create_tween()
	tween.tween_property(self, "cutoff", value, duration)
	await tween.finished
	finished.emit()

func transition_in(duration: float = 0.5):
	sound_in.play()
	material.set_shader_parameter("mask", mask_in)
	transition(0,duration)
func transition_out(duration: float = 0.5):
	sound_out.play()
	material.set_shader_parameter("mask", mask_out)
	transition(1,duration)


func _ready() -> void:
	if  auto_start:
		transition_in()

func _process(_delta: float) -> void:
	material.set_shader_parameter("cutoff_point", cutoff)
	mouse_filter = MOUSE_FILTER_IGNORE if cutoff <= 0 else MOUSE_FILTER_STOP
