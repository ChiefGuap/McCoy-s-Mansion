extends Node2D

@onready var sprite = $Sprite2D

# --- CONFIGURATION ---
# 1. The regions for the atlas (Sheet)
var closed_region = Rect2(32, 344, 32, 40) 
var open_region = Rect2(65, 329, 30, 70) # Ensure these dims match your Open Globe size

# 2. The new texture for the empty state
# We preload it so it's ready to swap instantly
var empty_texture = preload("res://assets/FancyMansion_Furniture/open_globe_no_drinks.png")

# --- STATE VARIABLES ---
var player_body = null
var is_open = false
var drinks_taken = false

func _ready():
	# Reset to initial state
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	
	# Ensure we are using the atlas and region for the closed state
	sprite.region_enabled = true
	sprite.region_rect = closed_region

func _input(event):
	if event.is_action_pressed("interact") and player_body != null:
		handle_interaction()

func handle_interaction():
	# PHASE 1: Open the globe
	if not is_open:
		is_open = true
		# We are still using the atlas here, just shifting the region
		sprite.region_rect = open_region
		print("You open the globe. Vintage spirits are inside.")
		
	# PHASE 2: Take the drinks
	elif is_open and not drinks_taken:
		drinks_taken = true
		#player_body.add_to_inventory("Vintage Spirits")
		
		# SWITCH TO THE NEW SEPARATE TEXTURE
		# 1. Turn off region_enabled because this new PNG is a standalone image, not a sheet
		sprite.region_enabled = false
		# 2. Assign the new texture
		sprite.texture = empty_texture
		sprite.offset.y = -7
		
		print("You took the drinks.")

# --- DETECTION ---
func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_body = body
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_body = null
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
