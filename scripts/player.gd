extends CharacterBody2D

const DEFAULT_MOVE_VELOCITY = 150
var movement_speed = DEFAULT_MOVE_VELOCITY
var collisions: Array[Node] = []
var collision_idx: int = 0
# 🔒 Control flag to lock movement
var is_locked: bool = false 


func _ready() -> void:
	position.x = 100
	position.y = 100
	$AnimatedSprite2D.play()


func _process(delta: float) -> void:
	
	# 🌟 Only allow movement input processing if the player is NOT locked
	if not is_locked:
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
			# Ensure animation is "default" if input is released and player is not locked
			$AnimatedSprite2D.animation = "default"
	
	# 🛑 If locked, ensure velocity is zero and set to idle animation
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.animation = "default"

	# The 'interact' logic remains active regardless of the lock state
	if Input.is_action_just_pressed("interact"):
		print("PRESSED E")
		if (collisions.size() > 1):
			var prev_body = collisions[collision_idx]
			prev_body.turn_off_outline()
			
			collision_idx += 1
			if (collision_idx >= collisions.size()):
				collision_idx = 0
			var body = collisions[collision_idx]
			
			body.turn_on_outline()
	
	_apply_movement()


func _apply_movement() -> void:
	move_and_slide()

# -----------------
# LOCK/UNLOCK FUNCTIONS
# -----------------

func lock_player() -> void:
	is_locked = true
	# Immediately stop any current movement
	velocity = Vector2.ZERO
	$AnimatedSprite2D.animation = "default"
	print("Player locked.")

func unlock_player() -> void:
	is_locked = false
	print("Player unlocked.")

# -----------------
# INTERACTABLE COLLISION FUNCTIONS
# -----------------

func _on_area_2d_area_entered(area: Area2D) -> void:
	var body: Node2D = area.get_parent()
	
	# outline this new target, clear prev outlines
	if (body is Interactable or body is InteractableV2) and body._interactable:
		collisions.append(body)
		
		if (collisions.size() > 1):
			var prev_body = collisions[collision_idx]
			prev_body.turn_off_outline()
			print("Removing outline to ", prev_body, " len ", collisions.size())
		
		body.turn_on_outline()
		collision_idx = collisions.size() - 1 
		print("Adding outline to ", body, " len ", collisions.size())
		

func _on_area_2d_area_exited(area: Area2D) -> void:
	var body = area.get_parent()
	var idx = collisions.find(body)
	
	if idx == -1:
		return

	if idx <= collision_idx:
		collision_idx -= 1
	
	if collision_idx < 0:
		collision_idx = 0
	
	collisions.erase(body)
	body.turn_off_outline()
	print("Removing outline to ", body, " len ", collisions.size())
	
	# ensure target gets passed if the current one was just removed
	if (collisions.size() > 0):
		var target = collisions[collision_idx]
		target.turn_on_outline()
