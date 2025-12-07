extends Node2D

# --- CONNECTIONS ---
@export var animation_player: AnimationPlayer
@export var dialogue_box: Control
@export var dialogue_label: Label
@export var black_screen: ColorRect
@export var blur_screen: ColorRect # <--- NEW! Drag your BlurScreen here
@export var game_scene: PackedScene 

# --- ACTORS ---
@export var player: Node2D
@export var mccoy: Node2D

func _ready():
	start_cutscene()

func start_cutscene():
	print("🎬 ACTION! Cutscene Started.")
	
	# 1. SETUP: Start Blurry & Hidden
	hide_text()
	if blur_screen:
		blur_screen.visible = true
		# Set blur to MAX (4.0) instantly
		blur_screen.material.set_shader_parameter("blur_amount", 4.0)
	
	# -----------------------------------------------------------
	# ACT 0: The "Wake Up" (Hypnosis Fades)
	# -----------------------------------------------------------
	print("😵 Waking up...")
	if blur_screen:
		var tween_blur = create_tween()
		# Slowly change blur from 4.0 to 0.0 over 4 seconds
		tween_blur.tween_property(blur_screen.material, "shader_parameter/blur_amount", 0.0, 4.0)
		
		# Optional: Wait for it to clear before talking?
		# Or let it talk WHILE clearing. Let's wait 2 seconds.
		await get_tree().create_timer(2.0).timeout
	
	# -----------------------------------------------------------
	# ACT 1: Player Speaks
	# -----------------------------------------------------------
	await show_text("How did I...", player) 
	await get_tree().create_timer(2.0).timeout 
	
	await show_text("END UP HERE!?!", player)
	await get_tree().create_timer(2.0).timeout
	
	hide_text()
	
	# -----------------------------------------------------------
	# ACT 2: Reveal & McCoy Speaks
	# -----------------------------------------------------------
	print("🎥 Panning to McCoy...")
	if animation_player and animation_player.has_animation("pan_to_mccoy"):
		animation_player.play("pan_to_mccoy")
		await animation_player.animation_finished
	
	await show_text("I sense someone...", mccoy)
	await get_tree().create_timer(2.0).timeout
	
	await show_text("I need hostages for my final plan!", mccoy)
	await get_tree().create_timer(3.0).timeout
	
	hide_text()
	
	# -----------------------------------------------------------
	# ACT 3: The Attack
	# -----------------------------------------------------------
	print("⚔️ ATTACK!")
	if animation_player and animation_player.has_animation("mccoy_kill"):
		animation_player.play("mccoy_kill")
		await animation_player.animation_finished
	
	# -----------------------------------------------------------
	# ACT 4: Fade Out & Switch Level
	# -----------------------------------------------------------
	print("🌑 Fading to Black...")
	if black_screen:
		black_screen.visible = true
		black_screen.z_index = 200
		black_screen.size = Vector2(5000, 5000)
		black_screen.position = Vector2(-2000, -2000)
		
	if animation_player and animation_player.has_animation("fade_out"):
		animation_player.play("fade_out")
		await animation_player.animation_finished
	
	print("🏰 Switching to Mansion...")
	if game_scene:
		get_tree().change_scene_to_packed(game_scene)

# --- HELPER FUNCTIONS ---
func show_text(text_to_show, who_is_talking):
	if dialogue_box:
		dialogue_box.visible = true
		if who_is_talking:
			var target_pos = who_is_talking.global_position
			dialogue_box.global_position = target_pos + Vector2(-50, -100)
			dialogue_box.z_index = 100 
	
	if dialogue_label:
		dialogue_label.text = text_to_show
		dialogue_label.add_theme_font_size_override("font_size", 7)
		dialogue_label.add_theme_color_override("font_color", Color.BLACK)
		dialogue_label.visible = true
		dialogue_label.modulate = Color(1, 1, 1, 1) 
		
	await get_tree().process_frame 

func hide_text():
	if dialogue_box:
		dialogue_box.visible = false
