# - Adapted to extend Interactable
extends Interactable

# 'sprite' is inherited from Interactable
@onready var jumpscare_layer = $JumpscareLayer
@onready var scream_sound = $ScreamSound

var is_scaring = false 
var penalty_applied = false

func _ready():
	# Allow the player to detect this object
	_interactable = true
	
	if jumpscare_layer:
		jumpscare_layer.visible = false

# Called by player.gd when 'E' is pressed on this object
func interact() -> void:
	if not is_scaring:
		trigger_jumpscare()

func trigger_jumpscare():
	is_scaring = true
	print("😱 JUMPSCARE TRIGGERED!")
	
	# Apply penalty once
	if not penalty_applied:
		var game = get_tree().current_scene
		if game and game.has_method("apply_jumpscare_penalty"):
			game.apply_jumpscare_penalty()
		penalty_applied = true
	
	# 1. Play Sound
	if scream_sound:
		scream_sound.play()
	
	# 2. Visual Strobe Effect
	if jumpscare_layer:
		# Flash 5 times quickly
		for i in range(5): 
			jumpscare_layer.visible = true
			await get_tree().create_timer(0.05).timeout
			jumpscare_layer.visible = false
			await get_tree().create_timer(0.05).timeout
		
		# Hold face
		jumpscare_layer.visible = true
		await get_tree().create_timer(1.0).timeout 
		jumpscare_layer.visible = false
	
	is_scaring = false

# Optional: Reset if player leaves range quickly
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		if jumpscare_layer:
			jumpscare_layer.visible = false
