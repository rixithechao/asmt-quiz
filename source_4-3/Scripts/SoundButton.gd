class_name SoundButton
extends Button

@export var player: AudioStreamPlayer
@export var progress: TextureProgressBar
@export var play_icon: Texture2D
@export var stop_icon: Texture2D


func _process(_delta: float) -> void:
	if  player.playing:
		progress.value = (player.get_playback_position()/player.stream.get_length())
	else:
		progress.value = 0

func _on_pressed() -> void:
	if  player.playing:
		icon = play_icon
		player.stop()
	else:
		icon = stop_icon
		player.play()

func _on_audio_stream_player_finished() -> void:
	icon = play_icon
