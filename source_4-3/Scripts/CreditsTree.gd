class_name CreditsTree
extends Tree


var root


func add_space():
	add_category(" ", [])

func add_line(header:String):
	add_category(header, [])

func add_category(header:String, items:Array[String]):
	var child = create_item(root)
	child.set_text(0, header)
	
	if  items.size() > 0:
		for item in items:
			var subchild = create_item(child)
			subchild.set_text(0, item)



func _ready():
	root = get_root()
	
	add_category("Main developer, background and logo art:", ["Rixithechao"])
	add_space()
	add_category("Questions by:", ["Name 1","Name 2","Name 3"])
	add_space()
	add_category("Sound effect sources (Freesound.org):", ["Slide Whistle (sheepfilms)","drumroll.wav (adriann)"])
	add_space()
	add_category("Sound effect sources (other):", ["Soniss GDC Audio Bundles"])
	add_space()
	add_category("ASMT games referenced:", ["Name 1","Name 2","Name 3"])
	add_space()
	add_category("Playtesters:", ["Name 1","Name 2","Name 3"])
	add_space()
	add_category("Special thanks:", ["raocow"])
	add_space()
	add_line("In loving memory of Sadie Erickson,
	who we had to say farewell to on November 19, 2024.  A sweet, loyal, and clever canine, she trained me and my family well.")
