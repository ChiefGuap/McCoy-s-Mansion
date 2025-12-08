extends Interactable

@onready var bedsprite = $BedSprite
var player_in_area = false # Tracks if player is inside the interaction zone
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var popup: = $Original # Assuming $Original is a Control node (CanvasLayer, TextureRect, etc.)

# 🌟 NEW STATE FLAG: Tracks if the item has been found and the popup is available
var popup_available: bool = false 
# 🌟 NEW STATE FLAG: Tracks if the item is currently open
var popup_is_open: bool = false

# 🌟 JUMPSCARE NODES - ASSUMING 'JumpscareLayer' and 'ScreamSound' are children of this node
@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound


func _ready():
	turn_on_interactable()
	popup.visible = false
	# Optional: Ensure the popup has a high Z-index or is on a CanvasLayer to appear over everything
	# popup.z_index = 100

func interact() -> void:
	# This function is not used in your current setup, but included for completeness
	pass

func _on_bed_entered(body):
	if body.name == "Player":
		player_in_area = true
		

func _on_bed_exited(body):
	if body.name == "Player":
		player_in_area = false
		# 🌟 NEW: If the player leaves while the popup is open, close it
		if popup_is_open:
			toggle_popup_display()


func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		
		# -----------------------------------------------
		# 1. HANDLE TOGGLE (Priority 1: If item is already found)
		# -----------------------------------------------
		if !Level3.clock_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "Looks Comfy"
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
				
				for i in 5:
					await get_tree().create_timer(0.05).timeout
					jumpscare_layer.visible = false
					await get_tree().create_timer(0.05).timeout
					jumpscare_layer.visible = true
					
				await get_tree().create_timer(1.5).timeout # Wait for the visual part to finish
				jumpscare_layer.visible = false
				
				player.unlock_player()
				hotbar.visible = true
				# Jumpscare Logic End
				return
		
		if popup_available:
			toggle_popup_display()
			return # Stop processing other logic
			
		# -----------------------------------------------
		# 2. HANDLE INITIAL DISCOVERY (Priority 2: If item is not found)
		# -----------------------------------------------
		
		# Lock player for the duration of the dialogue
		player.lock_player()
		hotbar.visible = false
		
		# Check coordinates for the hidden item
		if player.position.y > 90 and player.position.y < 120 and player.position.x > -240 and player.position.x < -220:
			
			# --- Discovery Dialogue ---
			box.visible = true
			label.visible = true
			box.size = Vector2(70, 25)
			label.add_theme_font_size_override("font_size", 7)
			label.modulate = Color(0, 0, 0, 1)

			label.text = "Something's here!"
			await get_tree().create_timer(2.0).timeout
			box.visible = false
			label.visible = false
			
			# --- Reveal Popup ---
			popup_available = true # Item is now found and available
			Level3.bed_done = true
			toggle_popup_display() # Show the popup immediately
			
			# NOTE: Player remains locked until they press 'E' again to close the popup.
		else:
			# --- Empty Dialogue ---
			box.visible = true
			label.visible = true
			box.size = Vector2(70, 25)
			label.add_theme_font_size_override("font_size", 8)
			label.modulate = Color(0, 0, 0, 1)

			label.text = "Nothing's here!"
			await get_tree().create_timer(2.0).timeout
			box.visible = false
			label.visible = false
			player.unlock_player() # Unlock immediately since nothing was found
			
# -----------------------------------------------
# 🌟 NEW TOGGLE FUNCTION
# -----------------------------------------------

func toggle_popup_display() -> void:
	# This function handles the showing and hiding of the 'Original' popup
	
	popup.visible = not popup.visible
	popup_is_open = popup.visible

	if popup_is_open:
		# If the popup is now visible, the player MUST be locked
		player.lock_player()
		hotbar.visible = false
		print("Popup opened. Player locked.")
	else:
		# If the popup is now hidden, the player MUST be unlocked
		player.unlock_player()
		hotbar.visible = true
		print("Popup closed. Player unlocked.")
