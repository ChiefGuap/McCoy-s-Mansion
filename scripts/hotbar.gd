extends TextureRect
class_name Hotbar

var items: Array[Node2D] = []
var maxItems = 5
var holding: int = 0
var slots: Array[ColorRect] = []
var selector: Panel # Reference to the purple highlight box

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var start_pos = Vector2(100, 220)
	var spacing = 80
	
	# 1. Create the Slots
	for i in range(5):
		var slot = ColorRect.new()
		slot.color = Color.GRAY
		slot.custom_minimum_size = Vector2(30, 30)  # size of slot
		
		var icon = TextureRect.new()
		icon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		icon.z_index = 50
		icon.z_as_relative = true
		icon.custom_minimum_size = Vector2(30, 30) # Ensure icon fits slot
		
		slot.position = start_pos + Vector2(i * spacing, 0)
		slot.add_child(icon)
		add_child(slot)
		slots.append(slot)
	
	for i in range(maxItems):
		items.append(null)
		
	# 2. Create the Purple Selector Box
	create_selector()
	
	# 3. Move it to the start position
	update_selector()


# Called every frame. 'delta' is the elapsed time since the previous frame.
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
	
	# Only update visuals if we actually switched slots
	if changed_slot:
		regenerate_hotbar_label()
		update_selector() # <--- Moves the purple box!

# --- NEW FUNCTION: Creates the visual box via code ---
func create_selector():
	selector = Panel.new()
	selector.size = Vector2(30, 30) # Match your slot size
	selector.z_index = 60           # Make sure it draws ON TOP of icons
	
	# Create the Purple Style
	var style = StyleBoxFlat.new()
	style.draw_center = false       # Transparent inside
	style.border_width_left = 3
	style.border_width_top = 3
	style.border_width_right = 3
	style.border_width_bottom = 3
	style.border_color = Color(0.6, 0.2, 1.0) # Bright Purple
	style.corner_radius_top_left = 2
	style.corner_radius_top_right = 2
	style.corner_radius_bottom_right = 2
	style.corner_radius_bottom_left = 2
	
	# Apply style and add to scene
	selector.add_theme_stylebox_override("panel", style)
	add_child(selector)

# --- NEW FUNCTION: Moves the box to the held slot ---
func update_selector():
	if slots.size() > holding:
		# Snap the selector to the exact position of the current slot
		selector.position = slots[holding].position

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

func add_to_hotbarv2(item: Node2D, sprite_name: String) -> void:
	var idx: int = 0;
	for i in range(maxItems):
		if items[i] == null:
			idx = i
			break
	var sprite: Sprite2D = item.get_node(sprite_name)
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
	
	# Use a safer check in case the label doesn't exist in some scenes
	if has_node("%HotbarLabel"):
		%HotbarLabel.text = text
