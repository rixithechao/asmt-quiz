class_name SettingsPanel
extends PanelContainer


@export var music_volume_slider: HSlider
@export var sound_volume_slider: HSlider
@export var fullscreen_button: CheckButton
@export var recording_check_dropdown: OptionButton
@export var recording_check_button: CheckButton



func reset_controls():
	var settings = SaveManager.settings
	music_volume_slider.value = settings.music_volume
	sound_volume_slider.value = settings.sound_volume
	fullscreen_button.button_pressed = settings.fullscreen
	recording_check_dropdown.selected = settings.recording_check
	recording_check_button.button_pressed = (settings.recording_check == 0)


func _ready() -> void:
	reset_controls()


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
