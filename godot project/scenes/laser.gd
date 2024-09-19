extends Area2D

var speed = 500

func _ready():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1,1), 0.15).from(Vector2(0,0))

func _process(delta):
	move_local_y(-speed * delta)
