class_name TitleScreen
extends Control


@export var title_tex: TextureRect
@export var bg_cover: ColorRect
@export var about_popup: AcceptDialog
@export var settings_popup: SettingsPanel
@export var question_select: Button
@export var version_label: Label
@export var duck_sound: AudioStreamPlayer
@export var transition_overlay: SceneTransitionOverlay

static var has_duck_played: bool = false

static var instance: TitleScreen


static func leave_this_screen():
	MusicManager.fade_out(0.25)
	instance.transition_overlay.visible = true
	instance.transition_overlay.transition_out()

static func quit_game():
	leave_this_screen()
	await instance.transition_overlay.finished
	instance.get_tree().quit()


func _ready() -> void:
	instance = self
	DisplayServer.window_set_title("Can You Smarter Than A Demo Sisters")
	question_select.visible = SaveManager.progress.free_mode_unlocked
	version_label.text = "v"+ProjectSettings.get_setting("application/config/version")
	if  not has_duck_played:
		has_duck_played = true
		duck_sound.play()
		transition_overlay.visible = false
		transition_overlay.cutoff = 0
	else:
		transition_overlay.transition_in()


func _process(_delta: float) -> void:
	title_tex.rotation_degrees = 4*sin(deg_to_rad(
0.1*Time.get_ticks_msec()))


func _on_start_pressed() -> void:
	leave_this_screen()
	await transition_overlay.finished
	get_tree().change_scene_to_file("res://Scenes/Scene_Main.tscn")

func _on_about_pressed() -> void:
	about_popup.visible = true
	bg_cover.visible = true

func _on_settings_pressed() -> void:
	settings_popup.reset_controls()
	settings_popup.visible = true
	bg_cover.visible = true

func _on_question_select_pressed() -> void:
	leave_this_screen()
	await transition_overlay.finished
	get_tree().change_scene_to_file("res://Scenes/Scene_QuestionSelect.tscn")
	#SaveManager.progress.questions_seen[q.resource_path]

func _on_quit_pressed() -> void:
	leave_this_screen()
	await transition_overlay.finished
	get_tree().quit()




func _on_about_confirmed() -> void:
	about_popup.visible = false
	bg_cover.visible = false
func _on_about_canceled() -> void:
	about_popup.visible = false
	bg_cover.visible = false


func _on_settings_close_pressed() -> void:
	settings_popup.visible = false
	bg_cover.visible = false
