class_name QuestionPage_MyDrink
extends QuestionPage_MultipleChoice


@export var my_drink_player: AnimationPlayer
@export var accept_input: bool = false
@export var drink_rect: TextureRect

var cursor_travel_dist: Vector2 = Vector2.ZERO

func give_answer(answer: Variant):
	selected = answer
	Input.warp_mouse(drink_rect.global_position + Vector2(0.5*drink_rect.size.x,0.67*drink_rect.size.y))
	for i in NUMBER_CHOICES:
		var btn = choice_buttons[i]
		btn.disabled = true
		ProjectUISoundController.disconnect_button_hovered(btn)

	my_drink_player.play("Wait")


func _input(event):
	if  accept_input:
		var disturbed_drink: bool = false
		
		if  event is InputEventMouseButton and event.pressed:
			disturbed_drink = true
		elif  event is InputEventMouseMotion:
			cursor_travel_dist += abs(event.relative)
			if  cursor_travel_dist.length() > 32:
				disturbed_drink = true

		if  disturbed_drink:
			my_drink_player.play("Spill")


func _on_my_drink_anim_animation_finished(anim_name: StringName) -> void:
	if  anim_name == "Wait":
		my_drink_player.play("NotSpill")
