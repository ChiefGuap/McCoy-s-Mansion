@abstract class_name InteractableV2
extends Node2D

@onready var sprite = $Sprite2D
@onready var sprite2 = $Sprite2DZUp

var _interactable = true

func turn_on_interactable():
	_interactable = true
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("outline_enabled", true)
	(sprite2.material as ShaderMaterial).set_shader_parameter("outline_enabled", true)

func turn_off_interactable():
	_interactable = false
	# Ensure the outline is invisible (thickness 0) when the game starts
	(sprite.material as ShaderMaterial).set_shader_parameter("outline_enabled", false)
	(sprite2.material as ShaderMaterial).set_shader_parameter("outline_enabled", false)

func turn_on_outline():
	# Turn outline on by setting thickness to 1.0
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)
	(sprite2.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func turn_off_outline():
	# Turn outline off
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	(sprite2.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)

@abstract func interact() -> void
