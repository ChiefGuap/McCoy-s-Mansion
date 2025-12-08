# - Adapted to extend Interactable
extends Interactable

# 'sprite' is already defined in Interactable, so we don't need to redeclare it.
@onready var popup_layer = $CanvasLayer 
@onready var hotbar = $"../../UI_Layer/Hotbar"

signal painting_switched

func _ready():
	# Allow the player to detect this object
	_interactable = true

# Called by player.gd when 'E' is pressed on this object
func interact() -> void:
	popup_layer.visible = not popup_layer.visible
	
	# Toggle hotbar visibility based on popup
	if popup_layer.visible:
		hotbar.visible = false
	else:
		hotbar.visible = true
		
	emit_signal("painting_switched")

# We keep this to auto-close the menu if the player walks away.
# The outline logic is removed because player.gd handles it now.
func _on_area_2d_body_exited(body):
	if body.name == "Player":
		popup_layer.visible = false
		hotbar.visible = true
