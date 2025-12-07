extends Interactable

# UI/Player References (Adjust paths if they change relative to the Chair node)
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
# Removed @onready var popup: Control = $CluePopup

# Chair Sprite/Position
@onready var chair_sprite: Sprite2D = $ChairSprite # Assuming the visual part is a Sprite2D

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
