extends SaveableData
class_name Save_Settings

# SaveManager.settings

@export var music_volume: float = 0.7
@export var sound_volume: float = 0.7

@export var recording_check: int = 0

@export var fullscreen: bool = false



#signal settings_changed


# Emit a signal whenever any of these properties are changed
#func _set(property: StringName, value: Variant) -> bool:
#	var signal_props = {"property": property, "value": value, "value_old": _get(property)}
#	emit_signal("settings_changed", signal_props)
#	return super._set(property, value)


func get_save_path():
	return "user://save_settings.tres"
