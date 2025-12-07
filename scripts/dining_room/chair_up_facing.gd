extends Interactable


func _ready() -> void:
	turn_on_interactable()
	pass # Replace with function body.


func interact() -> void:
	var idx = randi_range(0, 2)
	if idx == 0:
		display_dialouge("Just a \nchair")
	elif idx == 1:
		display_dialouge("Red chair")
	else:
		display_dialouge("Would Mccoy \nsit here?")
	pass

func display_dialouge(text):
	var dialogue_box = get_tree().root.find_child("DialougeBox", true, false)
	dialogue_box.size.y = 35
	var dialogue_label = dialogue_box.get_node("DialougeText")
	dialogue_box.visible = true
	# Force the text label to update AND be visible
	if dialogue_label:
		dialogue_label.add_theme_font_size_override("font_size", 7)
		dialogue_label.text = text
		# This is the secret sauce: Force it visible in case the animation hid it
		dialogue_label.position.y = 3
		dialogue_label.visible = true 
		# Ensure the color is white (or readable) just in case
		dialogue_label.modulate = Color(1, 1, 1, 1) 
	# Wait 3 seconds for reading
	await get_tree().create_timer(3.0).timeout
	# 4. HIDE TEXT
	if dialogue_box:
		dialogue_box.visible = false
		dialogue_box.size.y = 23
