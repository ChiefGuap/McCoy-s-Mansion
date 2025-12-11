extends InteractableV2


func _ready() -> void:
	turn_on_interactable()


func interact() -> void:
	turn_off_interactable()
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	hotbar.add_to_hotbar(%Key)
	DisplayDialouge.new().display_dialouge("A key under \nthe chair!")
