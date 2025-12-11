extends Control

func _on_button_pressed():
	# This is making sure to load the game scene 
	get_tree().change_scene_to_file("res://intro_woods.tscn")


func _on_how_to_play_pressed():
	# This is going to load to how to play scene
	get_tree().change_scene_to_file("res://how_to_play.tscn")
