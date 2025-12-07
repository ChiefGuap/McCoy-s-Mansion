extends Interactable


func _ready() -> void:
	turn_on_interactable()
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func interact() -> void:
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	var item: Node2D = hotbar.get_held_item()
	if (item != null):
		item.global_position = Vector2(global_position.x, global_position.y - 12)
		item.use_item()
		hotbar.remove_from_hotbar(item)
	pass
