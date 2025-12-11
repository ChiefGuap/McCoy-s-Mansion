extends Interactable
class_name Vase

signal remove_vase(vase_node)


func _ready() -> void:
	turn_on_interactable()


func interact() -> void:
	turn_off_interactable()
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	hotbar.add_to_hotbar(self)
	global_position = Vector2(1000, 1000)
	self.visible = false
	emit_signal("remove_vase", self)


func use_item() -> void:
	turn_on_interactable()
	self.visible = true
