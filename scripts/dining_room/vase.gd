extends Interactable


func _ready() -> void:
	turn_on_interactable()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func interact() -> void:
	turn_off_interactable()
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	hotbar.add_to_hotbar(self)
	self.visible = false

func use_item() -> void:
	turn_on_interactable()
	self.visible = true
	
