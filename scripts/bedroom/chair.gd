extends Interactable

# UI/Player References (Adjust paths if they change relative to the Chair node)
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
# Removed @onready var popup: Control = $CluePopup

# Chair Sprite/Position
@onready var chair_sprite: Sprite2D = $ChairSprite # Assuming the visual part is a Sprite2D

# 🌟 JUMPSCARE NODES
@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

# State Flags
var player_in_area: bool = false
var chair_pushed_in: bool = false # Tracks if the puzzle is solved

# 🌟 CUSTOMIZABLE: Define the position the chair moves to (e.g., tucking under the desk)
const PUSHED_IN_POSITION: Vector2 = Vector2(0, -30) # Example: move 30 pixels up/in

func interact() -> void:
	pass

func _ready():
	turn_on_interactable()

func _on_chair_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_chair_exited(body):
	if body.name == "Player":
		player_in_area = false


func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.vase_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "Who sat here?"
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
				jumpscare_layer.visible = false # Wait for the visual part to finish

				player.unlock_player()
				hotbar.visible = true
				# Jumpscare Logic End
				return
			
		# If the chair is already pushed in, do nothing (or show a simple message)
		if chair_pushed_in:
			return 
			
		# -----------------------------------------------
		# HANDLE PUSHING THE CHAIR (First interaction only)
		# -----------------------------------------------
		
		# 1. Lock player and hide hotbar
		player.lock_player()
		hotbar.visible = false
		
		# 2. Setup Dialogue Box
		box.visible = true
		label.visible = true
		box.size = Vector2(70, 25)
		label.add_theme_font_size_override("font_size", 7)
		label.modulate = Color(0, 0, 0, 1)

		label.text = "Pushed the chair!"
		# --- PERFORM THE PUSH ACTION ---
		Level3.chair_done = true
		chair_pushed_in = true
		self.position += PUSHED_IN_POSITION # Move the entire Chair node (and its children)
		
		await get_tree().create_timer(2).timeout # Short wait for player to read the message 
		
		label.text = "A door opened!"
		await get_tree().create_timer(2).timeout # Short wait for player to read the message 
		
		# --- CLEANUP ---
		box.visible = false
		label.visible = false
		
		# 3. Unlock Player and restore hotbar
		player.unlock_player()
		hotbar.visible = true
