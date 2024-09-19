extends Node2D

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()


# 1. load the scene
var asteroid_scene: PackedScene = load("res://scenes/asteroid.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

var health: int = 3

func _ready():
	# set up health ui
	get_tree().call_group("ui", "set_health", health)
	
	# stars
	var size := get_viewport().get_visible_rect().size
	var rng := RandomNumberGenerator.new()
	for star in $stars.get_children():
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		var random_scale = rng.randf_range(1, 2)
		star.scale = Vector2(random_scale, random_scale)
		
		star.speed_scale = rng.randf_range(0.5, 1.5)
	
	# clear inputs
	Input.action_release("boost")
	Input.action_release("laser")
	Input.action_release("right")
	Input.action_release("left")


func _on_asteroid_timer_timeout():
	# 2. create instance
	var asteroid = asteroid_scene.instantiate()
	
	# 3. attach node to scene tree
	$asteroids.add_child(asteroid)
	
	# connect the signal
	asteroid.connect("collision", _on_asteroid_collision)


func _on_asteroid_collision():
	health -= 1
	get_tree().call_group("ui", "set_health", health)
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")
	$Player.play_collision_sound()

func _on_player_laser(pos, rot):
	var laser = laser_scene.instantiate()
	$lasers.add_child(laser)
	laser.position = pos
	laser.rotation = rot

func _process(delta):
	$AsteroidTimer.wait_time = 0.5 - (Global.score * 0.01)


func _on_button_end_button_down():
	get_tree().quit()
