extends Node2D

# --- CONNECTIONS ---
@onready var sprite = $Sprite2D
@onready var jumpscare_layer = $JumpscareLayer
@onready var scream_sound = $ScreamSound

var player_in_range = false
var is_scaring = false 

func _ready():
	# 1. Hide outline shader if it exists
	if sprite.material:
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	
	# 2. Hide scary face ensuring it starts invisible
	if jumpscare_layer:
		jumpscare_layer.visible = false

func _input(event):
	# Trigger only if player presses 'E', is close, and not currently being scared
	if event.is_action_pressed("interact") and player_in_range and not is_scaring:
		trigger_jumpscare()

func trigger_jumpscare():
	is_scaring = true
	print("😱 JUMPSCARE TRIGGERED!")
	
	# 1. Play Sound
	if scream_sound:
		scream_sound.play()
	
	# 2. Visual Strobe Effect (Flashing)
	if jumpscare_layer:
		# Flash 5 times quickly
		for i in range(5): 
			jumpscare_layer.visible = true
			await get_tree().create_timer(0.05).timeout
			jumpscare_layer.visible = false
			await get_tree().create_timer(0.05).timeout
		
		# Hold the face on screen for 1 second
		jumpscare_layer.visible = true
		await get_tree().create_timer(1.0).timeout 
		jumpscare_layer.visible = false
	
	is_scaring = false

# --- DETECTION ---
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if sprite.material:
			(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		if sprite.material:
			(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		player_in_range = false
		if jumpscare_layer:
			jumpscare_layer.visible = false
