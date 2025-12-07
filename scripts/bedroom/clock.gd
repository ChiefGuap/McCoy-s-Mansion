extends Node2D

@onready var sprite = $ClockSprite
var player_in_area = false  # Tracks if player is inside the interaction zone
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var box = $"../../Player/DialougeBox"

func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)

func _on_clock_entered(body):
	if body.name == "Player":
		# Turn outline on by setting thickness to 1.0
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
		player_in_area = true
		

func _on_clock_exited(body):
	if body.name == "Player":
		# Turn outline off
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		player_in_area = false

func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		box.visible = true
		label.visible = true
		label.text = "The time is wrong"
		label.modulate = Color(0, 0, 0, 1)
		await get_tree().create_timer(3.0).timeout
		box.visible = false
		print("E was pressed while in area!")
		
