@abstract class_name Interactable
extends Node2D

@onready var sprite := $Sprite2D

var _interactable := false

func turn_on_interactable() -> void:
	_interactable = true
	(sprite.material as ShaderMaterial).set_shader_parameter("outline_enabled", true)

func turn_off_interactable() -> void:
	_interactable = false
	(sprite.material as ShaderMaterial).set_shader_parameter("outline_enabled", false)

func turn_on_outline() -> void:
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func turn_off_outline() -> void:
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)

@abstract func interact() -> void
