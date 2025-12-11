extends TextureRect
class_name Hotbar

var items: Array[Node2D] = []
var maxItems = 5
var holding: int = 0
var slots: Array[ColorRect] = []
var selector: Panel # purple highlight box

func _ready() -> void:
	var start_pos = Vector2(100, 220)
	var spacing = 80
	
	# Dynamically create and place the inventory slots
	for i in range(5):
		var slot = ColorRect.new()
		slot.color = Color.GRAY
		slot.custom_minimum_size = Vector2(30, 30)
		
		# Init icon whose texture will be swapped with sprites of items added to inventory
		var icon = TextureRect.new()
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.z_index = 50
		icon.z_as_relative = true
		icon.custom_minimum_size = Vector2(30, 30)
		
		slot.position = start_pos + Vector2(i * spacing, 0)
		slot.add_child(icon)
		
		add_child(slot)
		
		slots.append(slot)
	
	for i in range(maxItems):
		items.append(null)
		
	# Create the Purple Selector outline
	create_selector()


func _process(delta: float) -> void:
	var changed_slot = false
	
	if Input.is_action_just_pressed("1"):
		holding = 0
		changed_slot = true
	elif Input.is_action_just_pressed("2"):
		holding = 1
		changed_slot = true
	elif Input.is_action_just_pressed("3"):
		holding = 2
		changed_slot = true
	elif Input.is_action_just_pressed("4"):
		holding = 3
		changed_slot = true
	elif Input.is_action_just_pressed("5"):
		holding = 4
		changed_slot = true
	
	# If any of the above inputs were pressed
	if changed_slot:
		regenerate_hotbar_label()
		update_selector()


func create_selector():
	selector = Panel.new()
	selector.size = Vector2(30, 30)
	selector.z_index = 60 
	
	var style = StyleBoxFlat.new()
	style.draw_center = false
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.border_color = Color(0.6, 0.2, 1.0)
	style.corner_radius_top_left = 2
	style.corner_radius_top_right = 2
	style.corner_radius_bottom_right = 2
	style.corner_radius_bottom_left = 2
	
	selector.add_theme_stylebox_override("panel", style)
	
	# Initially place it on our first slot
	selector.position = slots[0].position
	
	add_child(selector)


func update_selector():
	if slots.size() > holding:
		selector.position = slots[holding].position


func add_to_hotbar(item: Node2D) -> void:
	var idx: int = -1;
	
	for i in range(maxItems):
		if items[i] == null:
			idx = i
			break
	
	items[idx] = item
	
	var sprite: Sprite2D = item.get_node("Sprite2D")
	
	var icon_texture = sprite.texture
	
	if sprite.region_enabled:
		#  If the sprite used by the item was cropped from an AtlasTexture ("region_enabled"), 
				# create a new Atlas Texture with only the cropped region
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = icon_texture
		atlas_texture.region = sprite.region_rect
		slots[idx].get_child(0).texture = atlas_texture
	else:
		slots[idx].get_child(0).texture = icon_texture
	
	regenerate_hotbar_label()


func add_to_hotbarv2(item: Node2D, sprite_name: String) -> void:
	var idx: int = 0;
	for i in range(maxItems):
		if items[i] == null:
			idx = i
			break
	
	items[idx] = item
	
	var sprite: Sprite2D = item.get_node(sprite_name)
	
	var icon_texture := sprite.texture
	
	if sprite.region_enabled:
		var atlas_texture = AtlasTexture.new()
		atlas_texture.atlas = icon_texture
		atlas_texture.region = sprite.region_rect
		slots[idx].get_child(0).texture = atlas_texture
	else:
		slots[idx].get_child(0).texture = icon_texture
	
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
