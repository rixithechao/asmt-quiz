class_name SettingsPanel
extends PanelContainer


@export var music_volume_slider: HSlider
@export var sound_volume_slider: HSlider
@export var fullscreen_button: CheckButton
@export var recording_check_dropdown: OptionButton
@export var recording_check_button: CheckButton

@export var delete_data_progress: ProgressBar
@export var delete_rev_sound: AudioStreamPlayer

var delete_data_percent: float = 0
var delete_data_state: int = 0
var performing_deletion: bool = false


func reset_controls():
	var settings = SaveManager.settings
	music_volume_slider.value = settings.music_volume
	sound_volume_slider.value = settings.sound_volume
	fullscreen_button.button_pressed = settings.fullscreen
	recording_check_dropdown.selected = settings.recording_check
	recording_check_button.button_pressed = (settings.recording_check == 0)


func _ready() -> void:
	reset_controls()

func _process(delta: float) -> void:
	delete_data_progress.visible = (delete_data_state != 0)
	if  delete_data_state == 1:
		delete_data_percent += delta
		delete_data_progress.value = delete_data_percent
		if  delete_data_percent >= delete_data_progress.max_value:
			delete_data_state = 2
			SaveManager.progress = Save_Progress.new()
			SaveManager.progress.save()
			TitleScreen.quit_game()


func _on_reset_pressed() -> void:
	SaveManager.settings = Save_Settings.new()
	SaveManager.settings.save()
	reset_controls()


func _on_music_volume_slider_drag_ended(value_changed: bool) -> void:
	SaveManager.settings.save()
func _on_music_volume_slider_value_changed(value: float) -> void:
	SaveManager.settings.music_volume = value
	AudioServer.set_bus_volume_db(SaveManager._bus_music, linear_to_db(value))

func _on_sound_volume_slider_drag_ended(value_changed: bool) -> void:
	SaveManager.settings.save()
func _on_sound_volume_slider_value_changed(value: float) -> void:
	SaveManager.settings.sound_volume = value
	AudioServer.set_bus_volume_db(SaveManager._bus_soundeffects, linear_to_db(value))

func _on_fullscreen_check_button_toggled(toggled_on: bool) -> void:
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if toggled_on else DisplayServer.WINDOW_MODE_WINDOWED)
	SaveManager.settings.fullscreen = toggled_on
	SaveManager.settings.save()
	#if  not toggled_on:
	#	DisplayServer.window_set_size(Vector2(1152, 648) * settings.screen_scale)


func _on_recording_check_dropdown_item_selected(index: int) -> void:
	SaveManager.settings.recording_check = index
	SaveManager.settings.save()

func _on_recording_check_button_toggled(toggled_on: bool) -> void:
	SaveManager.settings.recording_check = (0 if toggled_on else 2)
	SaveManager.settings.save()


func _on_delete_data_button_button_down() -> void:
	delete_data_state = 1
	delete_rev_sound.play(0)


func _on_delete_data_button_button_up() -> void:
	if  delete_data_state <= 1:
		delete_data_state = 0
		delete_data_percent = 0
		delete_rev_sound.stop()
