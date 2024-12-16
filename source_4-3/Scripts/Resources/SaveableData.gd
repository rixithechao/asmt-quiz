extends Resource
class_name SaveableData



func get_save_path():
	return "user://save_data.tres"


func save():
	var result = ResourceSaver.save(self, get_save_path())
	assert(result == OK)
