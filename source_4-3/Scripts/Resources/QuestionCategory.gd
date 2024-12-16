class_name QuestionCategory
extends Resource


const QUESTIONS_PER_CATEGORY: int = 5


@export var name: String
@export var name_size: float = 1
@export var icon: Image
@export var questions: Array[QuestionSlotResource]


func select_questions() -> Array[Question]:

	# the array to return
	var selected: Array[Question] = []
	
	# the number of questions in each difficulty pool;  assumes they are already ordered roughly in terms of difficulty
	var per_difficulty = floor(questions.size()/QUESTIONS_PER_CATEGORY)
	
	# reusable temporary array for slices as a pre-emtive (probably negligible) optimization
	var this_set: Array[QuestionSlotResource] = []
	# Ditto for individual question slot content and question
	var this_slot_resource: QuestionSlotResource
	var this_question: Question
	
	# Loop for each question
	for i in QUESTIONS_PER_CATEGORY:
		# Start and end of the slice
		var this_start = i*per_difficulty
		var next_start = (i+1)*per_difficulty
		
		# Avoid leaving out questions in the final difficulty slice
		if  i+1 >= QUESTIONS_PER_CATEGORY:
			next_start = questions.size()
		
		# Make the slice
		this_set = questions.slice(this_start, next_start)
		
		# Pick a random question from it
		this_slot_resource = this_set.pick_random()
		if  this_slot_resource is Question:
			this_question = this_slot_resource
		elif  this_slot_resource is QuestionVariantSet:
			this_question = this_slot_resource.variants.pick_random()
		selected.append(this_question)
	
	return selected
