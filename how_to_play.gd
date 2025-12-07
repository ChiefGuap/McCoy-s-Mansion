extends Control

func _on_back_button_pressed():
	# Go back to the Main Menu
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn") # Replace with function body.
