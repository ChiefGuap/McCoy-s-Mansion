extends InteractableV2

# --- CONNECTIONS ---
# Make sure you create these child nodes on the Chair!
@onready var jumpscare_layer = $ChairJumpscareLayer
@onready var scream_sound = $ChairScream

var is_scaring = false

func _ready() -> void:
	# This line from your parent class makes the "E" popup work
	turn_on_interactable()
	
	# Ensure the scary face is hidden when the game starts
	if jumpscare_layer:
		jumpscare_layer.visible = false

# This function is called automatically when the player presses 'E'
func interact() -> void:
	# Only scare if we aren't already in the middle of a scream
	if not is_scaring:
		trigger_jumpscare()

func trigger_jumpscare():
	is_scaring = true
	print("🪑 CHAIR JUMPSCARE TRIGGERED!")
	
	# 1. Play Sound
	if scream_sound:
		scream_sound.play()
	
	# 2. Visual Strobe Effect (Flashing)
	if jumpscare_layer:
		# Flash ON
		jumpscare_layer.visible = true
		await get_tree().create_timer(0.1).timeout
		
		# Flash OFF
		jumpscare_layer.visible = false
		await get_tree().create_timer(0.1).timeout
		
		# Flash ON (Hold it)
		jumpscare_layer.visible = true
		await get_tree().create_timer(1.5).timeout 
		
		# Hide it
		jumpscare_layer.visible = false
	
	is_scaring = false
