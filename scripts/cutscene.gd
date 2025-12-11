extends Node

@export var player: Node2D
@export var animation_player: AnimationPlayer
@export var dialogue_box: Control 
@export var dialogue_label: Label 

# Variable to hold the pacing animation so we can stop it later
var pacing_tween: Tween 
#test

func play_intro_cutscene():
	# 1. locking the player
	if player:
		player.lock_player()
	
	# 2. playing the animation
	if animation_player:
		animation_player.play("intro_cutscene")
		# waiting for the timeline to finish (7.0 seconds)
		await animation_player.animation_finished
	start_pacing()
	
	# 3. showing the text sequernce
	if dialogue_box:
		dialogue_box.visible = true
	
	# dialouge line number one 
	if dialogue_label:
		dialogue_label.add_theme_font_size_override("font_size", 7)
		dialogue_label.text = "I need to escape"
		
		# Position tweak
		dialogue_label.position.y += 3
		
		dialogue_label.visible = true 
		dialogue_label.modulate = Color(1, 1, 1, 1) 
	
	# Waiting then two seconds for the line one to finish
	await get_tree().create_timer(2.0).timeout

	# -the second dialouge line
	if dialogue_label:
		dialogue_label.text = "Maybe..."
	
	# then wait another three seconds
	await get_tree().create_timer(3.0).timeout
	
	if dialogue_label:
		dialogue_label.text = "I should check"
		
	await get_tree().create_timer(2.0).timeout
	if dialogue_label:
		dialogue_label.text = "Who owns this!?"
	# then wait two seconds
	await get_tree().create_timer(2.0).timeout
	
	if dialogue_label:
		dialogue_label.text = "MANSION"
	# then we have to wait one second
	await get_tree().create_timer(1.0).timeout
	stop_pacing()
	
	if dialogue_box:
		dialogue_box.visible = false
	
	# unlock the player
	if player:
		player.unlock_player()
	

# these are the helper functions
func start_pacing():
	if not player: return
	
	# Getting the sprite so we can animate the legs
	var sprite = player.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.play("run") 
	
	# creating the movement loop back and forth
	# .set_loops() makes it run forever until we kill it
	if pacing_tween: pacing_tween.kill()
	pacing_tween = create_tween().set_loops()
	
	var start_x = player.position.x
	
	# the forst movment part is walk Right (0.5 seconds)
	pacing_tween.tween_property(player, "position:x", start_x + 30, 0.5)
	# then it is flipping the sprite to walk back
	pacing_tween.tween_callback(func(): if sprite: sprite.flip_h = true)
	
	# then it iis walk Left (0.5 seconds)
	pacing_tween.tween_property(player, "position:x", start_x, 0.5)
	# flipping the sptiyr to walk back agaiuabn
	pacing_tween.tween_callback(func(): if sprite: sprite.flip_h = false)

func stop_pacing():
	if pacing_tween:
		pacing_tween.kill()
	
	if player:
		var sprite = player.get_node_or_null("AnimatedSprite2D")
		if sprite:
			sprite.play("idle")
			sprite.flip_h = false
