extends Interactable

# UI/Player References
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"

# 🌟 JUMPSCARE NODES
# Make sure you add these to the BottomRedCouch scene!
@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

var player_in_area = false  # Tracks if player is inside the interaction zone

func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	turn_on_interactable()

func interact() -> void:
	pass

func _on_bottomredcouch_entered(body):
	if body.name == "Player":
		# Turn outline on by setting thickness to 1.0
		player_in_area = true
		

func _on_bottomredcouch_exited(body):
	if body.name == "Player":
		# Turn outline off
		player_in_area = false

func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		# 60% chance for normal dialogue, 40% chance for Jumpscare
		if randf() < .60:
			box.visible = true
			label.visible = true
			label.text = "Fancy couch!"
			await get_tree().create_timer(2.0).timeout 
			box.visible = false
			label.visible = false
			return
		else:
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
