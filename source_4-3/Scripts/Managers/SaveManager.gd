extends ManagerParent

var slot : int = 0
var settings = Save_Settings.new()
var progress = Save_Progress.new()

@onready var _bus_music := AudioServer.get_bus_index("Music")
@onready var _bus_soundeffects := AudioServer.get_bus_index("SoundEffects")


func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS

	# Load or initialize progress
	var loaded_progress = load_data(progress.get_save_path())
	if  loaded_progress is Save_Progress:
		progress = loaded_progress


	# Load or initialize settings
	var loaded_settings = load_data(settings.get_save_path())
	if  loaded_settings is Save_Settings:
		settings = loaded_settings

		# Apply window settings
		#DisplayServer.window_set_vsync_mode(settings.vsync)
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if settings.fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
		#DisplayServer.window_set_size(Vector2(1152, 648) * settings.screen_scale)
		#DisplayServer.center_window()

		# Set the volume
		AudioServer.set_bus_volume_db(_bus_music, linear_to_db(settings.music_volume))
		AudioServer.set_bus_volume_db(_bus_soundeffects, linear_to_db(settings.sound_volume))


	# Initialize certain settings based on system defaults
	else:
		# Default vsync is going to vary from computer to computer
		#if  settings.locale == "":
		#	settings.locale = TranslationServer.get_locale()
		#settings.vsync = DisplayServer.window_get_vsync_mode()
		pass

	settings.save()



func new_game():
	pass


func load_data(file_name):
	if ResourceLoader.exists(file_name):
		return ResourceLoader.load(file_name)
	else:
		return null
