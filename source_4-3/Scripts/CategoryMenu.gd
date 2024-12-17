class_name CategoryMenu
extends GameplayScene


const REQUIRED_SCORE: float = 20
static var score: float = 0
static var remaining_questions: int = 0

@export var prompt_label: RandomizedGGLabel
@export var points_label: Label
@export var exit_dialog: ConfirmationDialog
@export var debug_button: Button


func _ready() -> void:
	instance = self
	prompt_label.next()
	set_score(0)


static func change_score(amount: float):
	set_score(score+amount)

static func set_score(val: float):
	score = val
	instance.points_label.text = str(score)+"/"+str(REQUIRED_SCORE)

static func transition_close():
	instance.prompt_label.next()
	super()



func _on_exit_pressed() -> void:
	exit_dialog.visible = true
	bg_cover_rect.visible = true

func _on_exit_confirm_confirmed() -> void:
	remaining_questions = 0
	get_tree().change_scene_to_file("res://Scenes/Scene_Title.tscn")

func _on_exit_confirm_canceled() -> void:
	exit_dialog.visible = false
	bg_cover_rect.visible = false


func _on_debug_pressed() -> void:
	remaining_questions = 1
	debug_button.disabled = true
