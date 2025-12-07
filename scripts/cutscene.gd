extends Node

# --- CONNECTIONS ---
# Make sure to drag these nodes into the Inspector slots!
@export var player: Node2D
@export var animation_player: AnimationPlayer
@export var dialogue_box: Control 
@export var dialogue_label: Label 

# Variable to hold the pacing animation so we can stop it later
var pacing_tween: Tween 

func play_intro_cutscene():
	print("🎬 CUTSCENE STARTED")
	
	# 1. LOCK PLAYER
<<<<<<< Updated upstream
	#if player:
		#player.lock_player()
=======
	# We use call_deferred or just call it directly depending on your setup
	if player:
		if player.has_method("lock_player"):
			player.lock_player()
		else:
			# Fallback if lock_player function is missing
			player.set_physics_process(false)
>>>>>>> Stashed changes
	
	# 2. PLAY ANIMATION (0s -> 7s)
	if animation_player:
		print("▶️ Playing animation timeline...")
		animation_player.play("intro_cutscene")
		# Wait for the timeline to finish (7.0 seconds)
		await animation_player.animation_finished
	
	print("✅ Animation finished. Starting Part 2...")
	
	# ---------------------------------------------------------
	# 3. START PACING (The Nervous Walk)
	# ---------------------------------------------------------
	start_pacing()
	
	# 4. SHOW TEXT SEQUENCE
	if dialogue_box:
		dialogue_box.visible = true
	
	# Force the text label to update AND be visible
	# --- DIALOGUE LINE 1 ---
	if dialogue_label:
		dialogue_label.add_theme_font_size_override("font_size", 7)
		dialogue_label.text = "I need to escape"
		# This is the secret sauce: Force it visible in case the animation hid it
		
		# Position tweak
		dialogue_label.position.y += 3
		
		dialogue_label.visible = true 
		# Ensure the color is white (or readable) just in case
		dialogue_label.modulate = Color(1, 1, 1, 1) 
		
	
	# Wait 3 seconds for reading
	# Wait 2 seconds for line 1
	await get_tree().create_timer(2.0).timeout

	# --- DIALOGUE LINE 2 ---
	if dialogue_label:
		dialogue_label.text = "Maybe..."
	
	# Wait 2 seconds for line 2
	await get_tree().create_timer(3.0).timeout
	
	# 4. HIDE TEXT
	if dialogue_label:
		dialogue_label.text = "I should check"
		
	await get_tree().create_timer(2.0).timeout
	# --- DIALOGUE LINE 3 ---
	if dialogue_label:
		dialogue_label.text = "Who owns this!?"
	# Wait 3 seconds for line 3
	await get_tree().create_timer(2.0).timeout
	
	if dialogue_label:
		dialogue_label.text = "MANSION"
	# Wait 3 seconds for line 3
	await get_tree().create_timer(1.0).timeout
	# 5. STOP PACING & HIDE TEXT
	stop_pacing()
	
	if dialogue_box:
		dialogue_box.visible = false
	
	
	# 6. UNLOCK PLAYER
<<<<<<< Updated upstream
	#if player:
		#player.unlock_player()
=======
	if player:
		if player.has_method("unlock_player"):
			player.unlock_player()
		else:
			player.set_physics_process(true)
>>>>>>> Stashed changes
	
	print("🏁 CUTSCENE FINISHED")

# --- HELPER FUNCTIONS FOR PACING ---

func start_pacing():
	if not player: return
	print("🚶 Pacing started...")
	
	# A. Get the sprite so we can animate the legs
	var sprite = player.get_node_or_null("AnimatedSprite2D")
	if sprite:
		sprite.play("run") # Make sure your player has a "run" animation!
	
	# B. Create the Movement Loop
	# .set_loops() makes it run forever until we kill it
	if pacing_tween: pacing_tween.kill()
	pacing_tween = create_tween().set_loops()
	
	var start_x = player.position.x
	
	# Step 1: Walk Right (0.5 seconds)
	pacing_tween.tween_property(player, "position:x", start_x + 30, 0.5)
	# Callback: Flip sprite to face Left
	pacing_tween.tween_callback(func(): if sprite: sprite.flip_h = true)
	
	# Step 2: Walk Left (0.5 seconds)
	pacing_tween.tween_property(player, "position:x", start_x, 0.5)
	# Callback: Flip sprite to face Right
	pacing_tween.tween_callback(func(): if sprite: sprite.flip_h = false)

func stop_pacing():
	print("🛑 Pacing stopped.")
	# Kill the movement tween
	if pacing_tween:
		pacing_tween.kill()
	
	# Reset sprite to Idle
	if player:
		var sprite = player.get_node_or_null("AnimatedSprite2D")
		if sprite:
			sprite.play("idle")
			sprite.flip_h = false
