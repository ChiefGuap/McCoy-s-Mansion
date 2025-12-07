extends Interactable


var player_in_area: bool = false # Tracks if player is inside the interaction zone

# UI/Player References (Adjust paths if they change relative to the Vase node)
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"

# 🌟 ASSUMED: This node holds your hidden clue image/text UI
@onready var popup = $Original

# State Flags
var vase_broken: bool = false # Tracks if the vase has been destroyed (first interaction)
var clue_is_open: bool = false # Tracks if the clue popup is currently visible


func _ready():
	# Set the initial visual state and make it interactable
	turn_on_interactable()
	popup.visible = false
	# Optional: If you have an Area2D that handles the detection, you might want to disable it later.
	

func interact() -> void:
	# Not used in this _process-based interaction style
	pass

func _on_vase_entered(body):
	if body.name == "Player":
		player_in_area = true
		

func _on_vase_exited(body):
	if body.name == "Player":
		player_in_area = false
		# If the player leaves while the clue popup is open, close it
		if clue_is_open:
			toggle_clue_display()

func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		
		# -----------------------------------------------
		# 1. HANDLE CLUE TOGGLE (Priority 1: If the vase is already broken)
		# -----------------------------------------------
		if !Level3.bed_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				player.lock_player()
				label.text = "What's inside?"
				await get_tree().create_timer(2.0).timeout 
				
				label.text = "Hands won't fit"
				await get_tree().create_timer(2.0).timeout 
				player.unlock_player()
				box.visible = false
				label.visible = false
				return
			else:
				#jumpscare
				print("Add jumpscare here")
				return
			
		if vase_broken:
			toggle_clue_display()
			return # Stop processing other logic
			
		# -----------------------------------------------
		# 2. HANDLE VASE DESTRUCTION (Priority 2: First interaction)
		# -----------------------------------------------
		
		# Lock player for the duration of the dialogue
		player.lock_player()
		hotbar.visible = false
		
		# --- Destruction Dialogue (First Message) ---
		box.visible = true
		label.visible = true
		box.size = Vector2(70, 25)
		label.add_theme_font_size_override("font_size", 7)
		label.modulate = Color(0, 0, 0, 1)

		label.text = "You hit the vase!"
		
		# VASE BREAKS
		vase_broken = true
		Level3.vase_done = true
		# If you have an Area2D, uncomment the line below to disable collision:
		# get_node("Area2D").set_deferred("monitoring", false) 
		
		await get_tree().create_timer(3.0).timeout 
		
		# --- Clue Revelation Dialogue (Second Message) ---
		label.text = "It shatters"
		
		await get_tree().create_timer(2.0).timeout
		
		label.text = "Inside's a note"
		
		await get_tree().create_timer(2.0).timeout
	
		
		box.visible = false
		label.visible = false
		
		# --- Show Clue Popup ---
		toggle_clue_display() # Show the clue immediately
		# NOTE: Player remains locked until they press 'E' again to close the popup.
		
		# Optional: Queue the vase node for deletion if you don't need it anymore
		# queue_free() 


# -----------------------------------------------
# CLUE TOGGLE FUNCTION
# -----------------------------------------------

func toggle_clue_display() -> void:
	# This function handles the showing and hiding of the clue popup
	
	popup.visible = not popup.visible
	clue_is_open = popup.visible

	if clue_is_open:
		# If the popup is now visible, the player MUST be locked
		player.lock_player()
		hotbar.visible = false
		print("Clue opened. Player locked.")
	else:
		# If the popup is now hidden, the player MUST be unlocked
		player.unlock_player()
		hotbar.visible = true
		global_position = Vector2(1000, 1000)
		self.visible = false
		print("Clue closed. Player unlocked.")
