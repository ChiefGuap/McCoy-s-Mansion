extends InteractableV2

# Make sure you create these child nodes on the Chair!
@onready var jumpscare_layer = $ChairJumpscareLayer
@onready var scream_sound = $ChairScream

var is_scaring = false

func _ready() -> void:
	turn_on_interactable()
	
	# Ensure the scary face is hidden when the game starts
	if jumpscare_layer:
		jumpscare_layer.visible = false

# when the player interacts with the chair
func interact() -> void:
	if not is_scaring:
		trigger_jumpscare()

func trigger_jumpscare():
	is_scaring = true


	if scream_sound:
		scream_sound.play()
	
	if jumpscare_layer:
		jumpscare_layer.visible = true
		await get_tree().create_timer(0.1).timeout
		
		jumpscare_layer.visible = false
		await get_tree().create_timer(0.1).timeout
		
		jumpscare_layer.visible = true
		await get_tree().create_timer(1.5).timeout 
		
		jumpscare_layer.visible = false
	
	is_scaring = false
