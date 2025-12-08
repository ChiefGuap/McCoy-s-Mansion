extends Interactable

var player_in_area: bool = false # Tracks if player is inside the interaction zone

# Dialogue/UI References
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var box = $"../../Player/DialougeBox"
@onready var input_popup_layer = $CanvasLayer # Renamed for clarity (Time Input Layer)
@onready var hotbar = $"../../UI_Layer/Hotbar"

# Player Reference
@onready var player = $"../../Player"

# Input Field Reference
@onready var input_field: LineEdit = $CanvasLayer/NinePatchRect2/LineEdit

# 🌟 NEW: Reference to your separate note UI element
# You must ensure you have a node named 'NoteCanvasLayer' in your scene hierarchy,
# placed at the same level as the $CanvasLayer used for input.
@onready var note_popup_layer: CanvasLayer = $note

# 🌟 JUMPSCARE NODES
@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

# Time/State Variables
var current_time: String = "06:09" 
var waiting_for_input: bool = false # Flag for time entry interaction state
var note_unlocked: bool = false # Flag that determines if the note is available

func interact() -> void:
	pass
	
func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	input_popup_layer.visible = false
	note_popup_layer.visible = false # Ensure note is hidden initially
	input_field.editable = true
	input_field.text_submitted.connect(_on_time_input_submitted)
	turn_on_interactable()


# -------------------------------------------------------------
# INTERACTION START/TOGGLE
# -------------------------------------------------------------

func _process(delta: float):
	# Logic for interaction depends on state:

	# Check for E press only when player is in area
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.paper_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "The time's wrong"
				await get_tree().create_timer(2.0).timeout 
				box.visible = false
				label.visible = false
				return
			else:
				#jumpscare
				# Jumpscare Logic Start
				player.lock_player()
				hotbar.visible = false
				jumpscare_layer.visible = true
				scream_sound.play()
				
				await get_tree().create_timer(0.2).timeout
				
				jumpscare_layer.visible = false
				
				await get_tree().create_timer(0.3).timeout # Wait for the visual part to finish

				player.unlock_player()
				hotbar.visible = true
				# Jumpscare Logic End
				return
		
		# 1. If the note is already unlocked, hitting E toggles the note
		if note_unlocked:
			toggle_note_display()
			return # Skip the time prompt logic
		
		# 2. If the note is NOT unlocked AND not waiting for input, start the time prompt
		if not waiting_for_input:
			start_time_prompt()


func toggle_note_display():
	# This function handles showing/hiding the note once it is unlocked
	
	# Toggle the note's visibility
	note_popup_layer.visible = not note_popup_layer.visible
	
	if note_popup_layer.visible:
		# Show the note: Lock player, hide hotbar
		player.lock_player()
		hotbar.visible = false
		print("Note displayed. Player locked.")
	else:
		# Hide the note: Unlock player, show hotbar
		player.unlock_player()
		hotbar.visible = true
		print("Note dismissed. Player unlocked.")


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
	await get_tree().create_timer(2.0).timeout

	# 5. Show Input Prompt and Field
	label.text = "Enter new time:"
	
	input_popup_layer.visible = true
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
	
	if hours > 23 or minutes > 59:
		label.text = "Time must be 0000-2359."
		input_field.clear()
		await get_tree().create_timer(1.5).timeout
		input_field.grab_focus()
		return

	# 3. Success: Change Time and Conclude Interaction
	current_time = "%02d:%02d" % [hours, minutes]
	label.text = "Time set to " + current_time + "."
	
	# 🌟 CHECK WINNING CONDITION
	if current_time == "06:07":
		input_popup_layer.visible = false
		await get_tree().create_timer(2).timeout
		label.text = "The clock chimes"
		await get_tree().create_timer(2).timeout
		label.text = "A note appeared!"
		note_unlocked = true # Note is now available for toggling
		Level3.clock_done = true
	
	# Final cleanup
	await get_tree().create_timer(0.5).timeout
	end_input_interaction()


func end_input_interaction():
	# 1. Hide all time input UI elements
	input_popup_layer.visible = false
	box.visible = false
	label.visible = false
	
	# 2. Unlock Player and Restore Hotbar (ONLY if the note hasn't been unlocked)
	
	player.unlock_player()
	hotbar.visible = true
	# If the note IS unlocked, the player stays locked until they interact again to view/dismiss the note.
	# 3. Reset state flag
	waiting_for_input = false


# -------------------------------------------------------------
# AREA COLLISION FUNCTIONS
# -------------------------------------------------------------

func _on_clock_entered(body):
	if body.name == "Player":
		player_in_area = true
		

func _on_clock_exited(body):
	if body.name == "Player":
		player_in_area = false
		
		# End any active time input
		if waiting_for_input:
			end_input_interaction()
		
		# If the note is open and the player leaves the area, close it
		if note_popup_layer.visible:
			toggle_note_display()
