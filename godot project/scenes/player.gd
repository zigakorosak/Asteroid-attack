extends Node2D

signal laser
signal rot

var velocity = 0
var max_velocity = 200
var acceleration = 200
var rotation_speed = 2

var can_shoot: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#print(DisplayServer.window_get_size()[0]) --- new: get_viewport().get_visible_rect().size
	position = Vector2(get_viewport().get_visible_rect().size.x*0.5,get_viewport().get_visible_rect().size.y*0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#--------------------------------------------------------------------#
	
	if position.y < 0:
		position.y = get_viewport().get_visible_rect().size.y
	elif position.y > get_viewport().get_visible_rect().size.y:
		position.y = 0
	if position.x < 0:
		position.x = get_viewport().get_visible_rect().size.x
	elif position.x > get_viewport().get_visible_rect().size.x:
		position.x = 0

	if Input.is_action_pressed("boost") && velocity < max_velocity:
		velocity += acceleration * delta
	elif velocity > 0:
		velocity -= acceleration * delta
	elif velocity < 0:
		velocity = 0

	if Input.is_action_pressed("left"):
		#velocity -= acceleration * delta * 2
		rotation -= rotation_speed * delta
		rot.emit(rotation)
	if Input.is_action_pressed("right"):
		#velocity -= acceleration * delta * 2
		rotation += rotation_speed * delta
		rot.emit(rotation)
	
	
	move_local_y(-velocity * delta)
	#$playerImage.move_local_y(-velocity * delta)
	#print($playerImage.get_global_transform())
	
	#--------------------------------------------------------------------#
	
	
	
	if Input.is_action_just_pressed("laser") and can_shoot:
		laser.emit($laserStartPos.global_position, rotation)
		can_shoot = false
		$laserTimer.start()
		$laserSound.play()

func play_collision_sound():
	$damageSound.play()

func _on_laser_timer_timeout():
	can_shoot = true
