class_name Question
extends Resource

var category: QuestionCategory
@export var author: String
@export var text: String
@export var page_scene: PackedScene = load("res://Prefabs/Prefab_QuestionPage_MChoice.tscn")
