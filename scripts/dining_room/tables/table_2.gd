extends Interactable

var vase: Vase = null

signal add_vase(tableNode, vaseNode)


func _ready() -> void:
	turn_on_interactable()


func interact() -> void:
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	var item: Node2D = hotbar.get_held_item()
	if (item != null and item is Vase):
		if vase == null:
			item.global_position = Vector2(global_position.x-6, global_position.y - 16)
			item.use_item()
			hotbar.remove_from_hotbar(item)
			vase = item
			item.z_index = 6
			emit_signal("add_vase", self, item)
		else:
			DisplayDialouge.new().display_dialouge("There's already \na vase there")
	elif vase == null:
		DisplayDialouge.new().display_dialouge("Something's \nmissing")
	else: # Player had already placed a vase and now interacting with the table
		DisplayDialouge.new().display_dialouge("A perfect place \nfor a vase!")
