extends Node
class_name DisplayDialouge

func display_dialouge(text):
	var dialogue_box = get_tree().root.find_child("DialougeBox", true, false)
	dialogue_box.size.y = 35
	var dialogue_label = dialogue_box.get_node("DialougeText")
	dialogue_box.visible = true
	
	dialogue_label.add_theme_font_size_override("font_size", 7)
	dialogue_label.text = text
	dialogue_label.position.y = 3
	dialogue_label.visible = true 
	dialogue_label.modulate = Color(1, 1, 1, 1) 

	await get_tree().create_timer(3.0).timeout

	dialogue_box.visible = false
	dialogue_box.size.y = 23
