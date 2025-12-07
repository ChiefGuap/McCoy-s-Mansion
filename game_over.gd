extends Control

func _ready() -> void:
	$VBoxContainer/RetryButton.pressed.connect(_on_retry_pressed)
	# If you added a quit button:
	# $VBoxContainer/QuitButton.pressed.connect(_on_quit_pressed)


func _on_retry_pressed() -> void:
	# Change this path to your Level 1 scene if it's not game.tscn
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
