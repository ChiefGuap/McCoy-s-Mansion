extends Node2D

@onready var paper = $PaperSprite
var player_in_area = false  # Tracks if player is inside the interaction zone
@onready var popup_layer = $CanvasLayer
@onready var hotbar = $"../../UI_Layer/Hotbar"


func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	(paper.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	popup_layer.visible = false

func _input(event):
	# Check if the "interact" key (E) was pressed
	if event.is_action_pressed("interact"):
		# If player is near, toggle the popup
		if player_in_area:
			popup_layer.visible = not popup_layer.visible
			if (popup_layer.visible):
				hotbar.visible = false
			else:
				hotbar.visible = true
			

func _on_paper_entered(body):
	if body.name == "Player":
		# Turn outline on by setting thickness to 1.0
		(paper.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
		player_in_area = true
		

func _on_paper_exited(body):
	if body.name == "Player":
		# Turn outline off
		(paper.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		player_in_area = false
		popup_layer.visible = false
		hotbar.visible = false
