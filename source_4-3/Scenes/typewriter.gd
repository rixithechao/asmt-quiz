class_name Typewriter
extends RichTextLabel


var seen_chars: float = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	visible_characters = 0

# Called every tick
func _process(delta):
	if visible_characters < text.length():
		seen_chars += 10 * delta
		if $LastWill.visible_characters != floor(seen_chars):
			if $LastWill.text.substr(seen_chars, 1) == " ":
				seen_chars += 1
			elif $LastWill.text.substr(seen_chars, 2) == "\n":
				seen_chars += 2
			else:
				$TextPlay.play()
			$LastWill.visible_characters = seen_chars
