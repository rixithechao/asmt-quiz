class_name RandomizedGGLabel
extends GGLabel

@export var randomize_on_start: bool = false
@export var text_pool: Array[String]

var index: int = 0


func _ready() -> void:
	text_pool.shuffle()
	if  randomize_on_start:
		next()

func next():
	var current: String = text
	
	if  index >= text_pool.size():
		text_pool.shuffle()
		index = 0
		while current == text_pool[index]:
			index += 1
	
	text = text_pool[index]
	index += 1
