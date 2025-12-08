extends Control

func _ready() -> void:
	$ReplayButton.pressed.connect(_on_replay_pressed)
	$QuitButton.pressed.connect(_on_quit_pressed)

func _on_replay_pressed() -> void:
	# back to Level 1 (change path if different)
	get_tree().change_scene_to_file("res://game.tscn")

func _on_quit_pressed() -> void:
	# back to main menu
	get_tree().change_scene_to_file("res://main_menu.tscn")
