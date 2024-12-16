extends ManagerParent



var all_questions: Array[Question]

var selected_categories: Array[QuestionCategory]
var selected_questions: Dictionary


func _ready() -> void:
	#var dir_path: String = "res://Data/QuestionCategory/"
	#var dir = DirAccess.open(dir_path)
	#var all_question_paths: PackedStringArray = dir.get_files()
	
	#print(all_question_paths)
	#for path in all_question_paths:
	#	var qRes = load(dir_path+path)
	#	all_questions.append(qRes)
	pass



func open_question(q: Question, points: int):
	CategoryMenu.transition_reset()
	#await get_tree().create_timer(0.01).timeout
	var page = q.page_scene.instantiate()
	page.points = points
	page.setup(q)
	CategoryMenu.instance.page_transform.add_child(page)
	CategoryMenu.transition_open()
