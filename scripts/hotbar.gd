extends TextureRect
class_name Hotbar

var items: Array[Node2D] = []
var maxItems = 5
var holding: int = 0
var slots: Array[ColorRect] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_pos = Vector2(100, 220)
	var spacing = 80
	for i in range(5):
		var slot = ColorRect.new()
		slot.color = Color.GRAY
		slot.custom_minimum_size = Vector2(30, 30)  # size of slot
		var icon = TextureRect.new()
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.z_index = 50
		icon.z_as_relative = true
		slot.position = start_pos + Vector2(i * spacing, 0)
		slot.add_child(icon)
		add_child(slot)
		slots.append(slot)
	
	for i in range(maxItems):
		items.append(null)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("1"):
		holding = 0
		regenerate_hotbar_label()
	elif Input.is_action_just_pressed("2"):
		holding = 1
		regenerate_hotbar_label()
	elif Input.is_action_just_pressed("3"):
		holding = 2
		regenerate_hotbar_label()
	elif Input.is_action_just_pressed("4"):
		holding = 3
		regenerate_hotbar_label()
	elif Input.is_action_just_pressed("5"):
		holding = 4
		regenerate_hotbar_label()
	
	pass

func add_to_hotbar(item: Node2D) -> void:
	var idx: int = 0;
	for i in range(maxItems):
		if items[i] == null:
			idx = i
			break
	var sprite: Sprite2D = item.get_node("Sprite2D")
	items[idx] = item
	var tex := sprite.texture
	if sprite.region_enabled:
		var atlas_tex = AtlasTexture.new()
		atlas_tex.atlas = tex
		atlas_tex.region = sprite.region_rect
		slots[idx].get_child(0).texture = atlas_tex
	else:
		slots[idx].get_child(0).texture = tex
	regenerate_hotbar_label()

func get_held_item() -> Node2D:
	return items[holding]

func remove_from_hotbar(item: Node2D) -> void:
	var idx = items.find(item)
	slots[idx].get_child(0).texture = null
	items[idx] = null
	regenerate_hotbar_label()

func regenerate_hotbar_label() -> void:
	var text = ""
	if items[holding] != null:
		text += "Holding " + items[holding].name
	%HotbarLabel.text = text
