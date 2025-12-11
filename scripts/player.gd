extends CharacterBody2D

const DEFAULT_MOVE_VELOCITY = 150
var movement_speed = DEFAULT_MOVE_VELOCITY
var collisions: Array[Node] = []
var collision_idx: int = 0
var is_locked: bool = false 


func _ready() -> void:
	position.x = 100
	position.y = 100
	$AnimatedSprite2D.play()


func _process(delta: float) -> void:
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
			$AnimatedSprite2D.animation = "default"	
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.animation = "default"
	
	if Input.is_action_just_pressed("toggle_selection"):
		if (collisions.size() > 1):
			var prev_body = collisions[collision_idx]
			prev_body.turn_off_outline()
			
			collision_idx += 1
			if (collision_idx >= collisions.size()):
				collision_idx = 0
			var body = collisions[collision_idx]
			
			body.turn_on_outline()
			regenerate_interact_label()
	
	if Input.is_action_just_pressed("interact"):
		if (collisions.size() > 0):
			var body = collisions[collision_idx]
			if body._interactable:
				body.interact()
	
	_apply_movement()


func _apply_movement() -> void:
	move_and_slide()


func lock_player() -> void:
	is_locked = true
	velocity = Vector2.ZERO
	$AnimatedSprite2D.animation = "default"

func unlock_player() -> void:
	is_locked = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	var body: Node2D = area.get_parent()
	
	# outline this new target, clear prev outlines
	if (body is Interactable or body is InteractableV2) and body._interactable:
		collisions.append(body)
		
		if (collisions.size() > 1):
			var prev_body = collisions[collision_idx]
			prev_body.turn_off_outline()
		
		body.turn_on_outline()
		collision_idx = collisions.size() - 1 
		
		regenerate_interact_label()


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
	
	# ensure target selection gets passed to a diff object if the current one was just removed
	if (collisions.size() > 0):
		var target = collisions[collision_idx]
		target.turn_on_outline()
	regenerate_interact_label()


func regenerate_interact_label() -> void:
	var label = get_tree().root.find_child("InteractLabel", true, false)
	var text = ""
	if (collisions.size() > 0):
		text += "Press e to interact"
	if (collisions.size() > 1):
		text += "\nPress x to toggle selection <" + str(collision_idx+1) + "/" + str(collisions.size()) + ">"
	label.text = text
