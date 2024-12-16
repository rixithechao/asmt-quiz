class_name MusicDisplay
extends PanelContainer


@export var name_label: Label
@export var author_label: Label
@export var time_label: Label
@export var length_label: Label
@export var progress: ProgressBar
@export var player: AudioStreamPlayer


func get_time_string(secs: float) -> String:
	var seconds = floori(secs) % 60
	var minutes = floori(secs / 60)
	return "%02d:%02d" % [minutes, seconds]



func _ready() -> void:
	MusicManager.player = player
	MusicManager.info = self
	MusicManager.next()


func _process(_delta: float) -> void:
	player = MusicManager.player

	if  player.playing:
		var stream = player.stream

		var data = MusicManager.queue[0]
		var current_seconds = player.get_playback_position()
		var length_seconds = stream.get_length()

		time_label.text = get_time_string(current_seconds)
		progress.value = (current_seconds/length_seconds)
		
		#if  stream_cache != :
		#	pass


func update_track_info():
	var current_data = MusicManager.queue[0]
	name_label.text = current_data.name

	var stream = current_data.stream
	length_label.text = get_time_string(stream.get_length())
	
	var author: String = "AUTHOR" if current_data.author == "" else current_data.author
	var album: String = "ALBUM" if current_data.album == "" else current_data.album
	author_label.text = author + " -- " + album


func _on_music_finished() -> void:
	MusicManager.next()
