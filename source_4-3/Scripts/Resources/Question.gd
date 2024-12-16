class_name Question
extends QuestionSlotResource

var category: QuestionCategory
@export var author: String
@export_multiline var text: String
@export var page_scene: PackedScene = load("res://Prefabs/Prefab_QuestionPage_MChoice.tscn")

@export var seconds: int = 0

@export_group("Sound")
@export var sound: AudioStream
@export var pause_music: bool = false

@export_group("Images")
@export var image: Texture2D
@export var image_answered: Texture2D
@export var specific_answer_images: Dictionary
