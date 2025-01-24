extends Node

var player: AudioStreamPlayer
var info: MusicDisplay

#var data: Dictionary = {}

var queue: Array[MusicData] = [
	preload("res://Data/MusicData/Music_A2MT_Mansion.tres"),
	preload("res://Data/MusicData/Music_A2XT_Castle.tres"),
	preload("res://Data/MusicData/Music_A2XT2_CityMap.tres"),
]
var queue_played: Array[MusicData] = []

var volume_fade: float = 1
var fade_tween: Tween


func _ready() -> void:
	queue.shuffle()
	
	# Import all music data and index it by its streams
	#var dir_path: String = "res://Data/Music/"
	#var dir = DirAccess.open(dir_path)
	#var all_music_data: PackedStringArray = dir.get_files()
	#for  path in all_music_data:
	#	var file = load(path)
	#	var stream = file.stream
	#	data[stream] = file

func next():
	var last = player.stream

	queue_played.append(queue.pop_front())
	if  queue.size() == 0:
		queue_played.shuffle()
		while (queue_played[0].stream == last):
			queue_played.shuffle()
		queue.append_array(queue_played)
		queue_played.clear()
	player.stream = queue[0].stream
	player.play()
	info.update_track_info()

func pause():
	player.stream_paused = true
func unpause():
	player.stream_paused = false

func abort_fade():
	if fade_tween != null  and  fade_tween.is_valid()  and  fade_tween.is_running():
		fade_tween.kill()

func fade(amount: float, duration: float = 1):
	abort_fade()
	fade_tween = get_tree().create_tween()
	fade_tween.tween_property(self, "volume_fade", amount, duration)
func fade_out(duration: float = 1):
	fade(0, duration)
func fade_in(duration: float = 1):
	fade(0, duration)
