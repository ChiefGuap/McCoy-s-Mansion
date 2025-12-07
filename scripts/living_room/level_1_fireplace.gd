extends Node2D

@onready var sprite = $BaseFireplace
@onready var popup_layer = $CanvasLayer
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var point_light = $PointLight2D

# Visual References
@onready var anim_sprite = $CanvasLayer/AnimatedSprite2D
@onready var extinguished_sprite = $CanvasLayer/ExtinguishedSprite
@onready var world_extinguished_sprite = $BaseExtinguishedSprite # The new node you added

var player_in_range = false
var is_fire_lit = true

func _ready():
	# Ensure lines are off and correct sprites are hidden/shown
	(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	(world_extinguished_sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
	
	popup_layer.visible = false
	world_extinguished_sprite.visible = false
	sprite.visible = true

func _input(event):
	if event.is_action_pressed("interact") and player_in_range:
		# 1. If popup is closed, open it
		if not popup_layer.visible:
			popup_layer.visible = true
			hotbar.visible = false
			
		# 2. If popup is open, handle interaction
		else:
			if is_fire_lit:
				# CHECK: Does the player have the drinks?
				if has_drinks():
					extinguish_fire()
				else:
					# Optional: Add feedback like a label or print
					print("You need something to extinguish the fire!") 
			else:
				close_popup()

func has_drinks() -> bool:
	var item = hotbar.get_held_item()
	# We check for the 'drinks_taken' property specifically found in the globe script
	if item != null and item.get("drinks_taken") == true:
		return true
	return false

func extinguish_fire():
	is_fire_lit = false
	
	# Update Popup Visuals
	anim_sprite.visible = false
	extinguished_sprite.visible = true
	
	# Update World Visuals
	sprite.visible = false
	world_extinguished_sprite.visible = true
	point_light.enabled = false # Turn off the light
	
	# Apply outline to the new visible sprite if player is still looking at it
	(world_extinguished_sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func close_popup():
	popup_layer.visible = false
	hotbar.visible = true

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player_in_range = true
		# Apply outline to whichever sprite is currently visible
		var target = sprite if is_fire_lit else world_extinguished_sprite
		(target.material as ShaderMaterial).set_shader_parameter("line_thickness", 1.0)

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		player_in_range = false
		# Clear outline on both to be safe
		(sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		(world_extinguished_sprite.material as ShaderMaterial).set_shader_parameter("line_thickness", 0.0)
		
		close_popup()
