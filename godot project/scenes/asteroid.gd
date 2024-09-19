extends Area2D

var speed: int
var rotation_speed: int
var direction_x: float
var size: float

signal collision
var can_collide := true

func _ready():
	var rng := RandomNumberGenerator.new()
	
	var path: String = "res://media/asteroids/" + str("asteroid") + str(rng.randi_range(1,3)) + ".png"
	$asteroidImage.texture = load(path)
	
	# star position
	var width = DisplayServer.window_get_size()[0]
	var rand_x = rng.randi_range(0, width)
	var rand_y = rng.randi_range(-150, -50)
	position = Vector2(rand_x, rand_y)
	
	speed = rng.randi_range(50, 250)
	direction_x = rng.randf_range(-1, 1)
	rotation_speed = randi_range(-100, 100)
	size = randf_range(0.5, 2)
	
	scale *= size

func _process(delta):
	position += Vector2(direction_x, 1.0) * speed * delta
	rotation_degrees += rotation_speed * delta



func _on_body_entered(_body):
	if can_collide:
		collision.emit()


func _on_area_entered(area):
	area.queue_free()
	$explosionSound.play()
	$asteroidImage.hide()
	can_collide = false
	await get_tree().create_timer(1).timeout
	queue_free()
