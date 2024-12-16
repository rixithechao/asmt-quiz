@tool
class_name MaskTransition
extends TextureRect

@export var cutoff: float


func _process(_delta: float) -> void:
	material.set_shader_parameter("mask",texture)
	material.set_shader_parameter("cutoff_point", cutoff)
