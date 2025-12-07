extends Node2D

@onready var sprite = $Sprite2D
@onready var popup_layer = $CanvasLayer # Reference to the UI we just made

var player_in_range = false

func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	# Ensure popup is hidden
	# hey
	popup_layer.visible = false

func _input(event):
	# Check if the "interact" key (E) was pressed
	if event.is_action_pressed("interact"):
		# If player is near, toggle the popup
		if player_in_range:
			popup_layer.visible = not popup_layer.visible
		
		# Optional: If the popup is open and we press E again, close it (handled by toggle above)
		# But if you want 'Esc' to close it too, you can add that logic here.

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		# Turn outline on
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
		player_in_range = true

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		# Turn outline off
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		player_in_range = false
		
		# Force close the popup if the player walks away
		popup_layer.visible = false
