extends Node2D

@export var paper_done = false
@export var clock_done = false
@export var bed_done = false
@export var vase_done = false
@export var chair_done = false
@export var hint_label: Label

func _ready() -> void:
	if hint_label:
		hint_label.visible = false

func enter_level() -> void:
	if hint_label:
		hint_label.visible = true
		hint_label.text = "I SHOULD CHECK IF MCCOY WROTE ANYTHING THAT COULD HELP ME..."
		get_tree().create_timer(5.0).timeout.connect(func(): hint_label.visible = false)
