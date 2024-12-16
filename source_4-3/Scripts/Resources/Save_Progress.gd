extends SaveableData
class_name Save_Progress

# SaveManager.progress

@export var questions_seen: Dictionary
@export var free_mode_unlocked: bool = false
@export var high_score: int = 0


func get_save_path():
	return "user://save_progress.tres"
