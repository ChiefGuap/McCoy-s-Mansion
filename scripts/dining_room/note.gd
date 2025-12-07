extends Node2D
class_name Note

@onready var popup_layer = $Original

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	popup_layer.visible = false

func make_visible() -> void:
	popup_layer.visible = true

func make_invisible() -> void:
	popup_layer.visible = false
