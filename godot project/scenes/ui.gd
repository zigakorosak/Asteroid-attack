extends CanvasLayer

static var image = load("res://media/rocket.png")
var time_elapsed := 0

func set_health(amount):
	# remove all children
	for child in $MarginContainer2/HBoxContainer.get_children():
		child.queue_free()
	
	# create new children amount is set by health
	for i in amount:
		var text_rect = TextureRect.new()
		text_rect.texture = image
		$MarginContainer2/HBoxContainer.add_child(text_rect)


func _on_score_timer_timeout():
	time_elapsed += 1
	$MarginContainer/Label.text = str(time_elapsed)
	Global.score = time_elapsed


func _on_button_right_pressed():
	Input.action_press("right")


func _on_button_right_released():
	Input.action_release("right")


func _on_button_left_pressed():
	Input.action_press("left")


func _on_button_left_released():
	Input.action_release("left")


func _on_button_boost_pressed():
	Input.action_press("boost")


func _on_button_boost_released():
	Input.action_release("boost")


func _on_button_laser_pressed():
	Input.action_press("laser")


func _on_button_laser_released():
	Input.action_release("laser")
