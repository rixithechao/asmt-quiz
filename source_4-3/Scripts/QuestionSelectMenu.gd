class_name QuestionSelectMenu
extends Control

@export var category_groups: Array[CategoryGroup]
@export var column_prefab: PackedScene
@export var column_container: FlowContainer



func _ready() -> void:
	for  g in category_groups:
		for c in g.categories:
			var col = column_prefab.instantiate()
			column_container.add_child(col)
			col.populate(c)


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")
