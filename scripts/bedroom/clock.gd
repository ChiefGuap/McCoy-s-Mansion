extends Node2D

@onready var sprite = $ClockSprite
var player_in_area: bool = false # Tracks if player is inside the interaction zone

# Dialogue/UI References
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var box = $"../../Player/DialougeBox"
@onready var popup_layer = $CanvasLayer
@onready var hotbar = $"../../UI_Layer/Hotbar"

# Player Reference
@onready var player = $"../../Player"

# Input Field Reference (Assuming it's inside a NinePatchRect, which is inside CanvasLayer)
@onready var input_field: LineEdit = $CanvasLayer/NinePatchRect2/LineEdit

# Time/State Variables
var current_time: String = "06:09" # Use a more descriptive name than 'time'
var waiting_for_input: bool = false # Flag to manage if the LineEdit is active


func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	popup_layer.visible = false
	# 🌟 NEW: Ensure the input field is set to be editable and handles submission
	input_field.editable = true
	input_field.text_submitted.connect(_on_time_input_submitted)


# -------------------------------------------------------------
# INTERACTION START/TOGGLE
# -------------------------------------------------------------

func _process(delta: float):
	# Only allow a new interaction when the player is in the area and NOT waiting for input
	if player_in_area and Input.is_action_just_pressed("interact") and not waiting_for_input:
		start_time_prompt()


func start_time_prompt():
	# 1. Lock Player and Hide Hotbar
	player.lock_player()
	hotbar.visible = false
	waiting_for_input = true
	
	# 2. Setup Dialogue Box
	box.visible = true
	label.visible = true
	box.size = Vector2(70, 25)
	label.add_theme_font_size_override("font_size", 7)
	label.modulate = Color(0, 0, 0, 1)

	# 3. Initial Message
	label.text = "The time is " + current_time
	
	# 4. Wait for initial message to pass
	await get_tree().create_timer(2.0).timeout # Reduced delay for better feel

	# 5. Show Input Prompt and Field
	label.text = "Enter new time"
	
	popup_layer.visible = true
	input_field.text = "" # Clear old input
	input_field.grab_focus() # Allow the user to start typing immediately


# -------------------------------------------------------------
# INPUT SUBMISSION AND VALIDATION
# -------------------------------------------------------------

func _on_time_input_submitted(submitted_text: String):
	# Ensure we are in the correct state
	if not waiting_for_input: return
	
	# Remove focus from input field
	input_field.release_focus()

	# 1. Validation (HHMM check)
	if submitted_text.length() != 4 or not submitted_text.is_valid_int():
		label.text = "Invalid format. Use HHMM."
		input_field.clear()
		await get_tree().create_timer(1.5).timeout
		input_field.grab_focus() # Focus again for re-entry
		return

	# 2. Extract and Validate Time Bounds
	var input_time_int = submitted_text.to_int()
	var hours = input_time_int / 100
	var minutes = input_time_int % 100
	

	# 3. Success: Change Time and Conclude Interaction
	current_time = "%02d:%02d" % [hours, minutes]
	label.text = "Time set to " + current_time + "."
	
	# Final cleanup
	await get_tree().create_timer(1.5).timeout
	end_interaction()


func end_interaction():
	# 1. Hide all UI elements
	popup_layer.visible = false
	box.visible = false
	label.visible = false
	
	# 2. Unlock Player and Restore Hotbar
	player.unlock_player()
	hotbar.visible = true
	
	# 3. Reset state flag
	waiting_for_input = false


# -------------------------------------------------------------
# AREA COLLISION FUNCTIONS (No major changes needed here)
# -------------------------------------------------------------

func _on_clock_entered(body):
	if body.name == "Player":
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
		player_in_area = true
		

func _on_clock_exited(body):
	if body.name == "Player":
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		player_in_area = false
		
		# 🌟 NEW: End interaction if player leaves while it's active
		if waiting_for_input:
			end_interaction()
