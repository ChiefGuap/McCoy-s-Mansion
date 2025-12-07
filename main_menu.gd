extends Control

func _on_button_pressed():
	# This loads your game scene.
	# Make sure the path "res://game.tscn" matches your actual file name!
	get_tree().change_scene_to_file("res://intro_woods.tscn")
