extends Interactable


func _ready() -> void:
	turn_on_interactable()


func interact() -> void:
	var idx = randi_range(0, 2)
	if idx == 0:
		DisplayDialouge.new().display_dialouge("Just a \nchair")
	elif idx == 1:
		DisplayDialouge.new().display_dialouge("Red chair")
	else:
		DisplayDialouge.new().display_dialouge("Would Mccoy \nsit here?")
