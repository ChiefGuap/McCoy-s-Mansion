extends Node2D

@onready var sprite = $Sprite2D

func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		# Turn outline on by setting thickness to 1.0
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		# Turn outline off
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
