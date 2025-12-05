extends Node

# --- CONNECTIONS ---
# Make sure to drag these nodes into the Inspector slots!
@export var player: Node2D
@export var animation_player: AnimationPlayer
@export var dialogue_box: Control 
@export var dialogue_label: Label 

func play_intro_cutscene():
	print("🎬 CUTSCENE STARTED")
	
	# 1. LOCK PLAYER
	if player:
		player.set_physics_process(false)
	
	# 2. PLAY ANIMATION (0s -> 7s)
	if animation_player:
		print("▶️ Playing animation timeline...")
		animation_player.play("intro_cutscene")
		# Wait for the timeline to finish (7.0 seconds)
		await animation_player.animation_finished
	
	print("✅ Animation finished. Starting Part 2...")
	
	# 3. SHOW TEXT (7s -> 10s)
	# Force the text box to appear
	if dialogue_box:
		dialogue_box.visible = true
	
	# Force the text label to update AND be visible
	if dialogue_label:
		dialogue_label.add_theme_font_size_override("font_size", 7)
		dialogue_label.text = "I need to escape"
		# This is the secret sauce: Force it visible in case the animation hid it
		dialogue_label.visible = true 
		# Ensure the color is white (or readable) just in case
		dialogue_label.modulate = Color(1, 1, 1, 1) 
	
	# Wait 3 seconds for reading
	await get_tree().create_timer(3.0).timeout
	
	# 4. HIDE TEXT
	if dialogue_box:
		dialogue_box.visible = false
	
	
	# 6. UNLOCK PLAYER
	if player:
		player.set_physics_process(true)
	
	print("🏁 CUTSCENE FINISHED")
