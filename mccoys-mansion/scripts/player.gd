extends CharacterBody2D


const DEFAULT_MOVE_VELOCITY = 150
var movement_speed = DEFAULT_MOVE_VELOCITY


func _ready() -> void:
	position.x = 100
	position.y = 100
	$AnimatedSprite2D.play()


func _process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_left"):
		velocity.x += -1
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y += -1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * movement_speed
		$AnimatedSprite2D.animation = "run"
	else:
		$AnimatedSprite2D.animation = "default"
	
	_apply_movement()


func _apply_movement() -> void:
	move_and_slide()
	
