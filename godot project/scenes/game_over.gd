extends Control

@export var level_scene: PackedScene

var waited =  false

#func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#get_tree().quit()
	#
	#
	#if event.is_action_pressed("laser"):
		#get_tree().change_scene_to_packed(level_scene)


func _ready():
	$CenterContainer/VBoxContainer/Label2.text = $CenterContainer/VBoxContainer/Label2.text + str(Global.score)
	
	
	await get_tree().create_timer(3).timeout
	waited = true


func _gui_input(event: InputEvent) -> void:
	#if event is InputEventMouseButton and event.pressed:
		#if event.button_index == MOUSE_BUTTON_LEFT:
			#get_tree().change_scene_to_packed(level_scene)
	
	# Check if the event is a screen touch event (used in mobile).
	if event is InputEventScreenTouch and waited:
		get_tree().change_scene_to_packed(level_scene)


func _on_button_end_button_down():
		get_tree().quit()
