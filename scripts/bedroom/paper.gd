extends Interactable

@onready var paper = $PaperSprite
var player_in_area = false  # Tracks if player is inside the interaction zone
@onready var popup_layer = $Original
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var bottle = $"../Bottle"
@onready var torch = $"../Torch"
@onready var dirty = $Original/ColorRect
@onready var blue = $Original/Blue


func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	popup_layer.visible = false
	turn_on_interactable()
	

func interact() -> void:
	pass

func _input(event):
	# Check if the "interact" key (E) was pressed
	if event.is_action_pressed("interact"):
		# If player is near, toggle the popup
		var item = hotbar.get_held_item()
		print(item)
		if item == bottle:
			dirty.visible = false
		if item == torch:
			blue.visible = false
			
		
		if player_in_area:
			popup_layer.visible = not popup_layer.visible
			if (popup_layer.visible):
				hotbar.visible = false
			else:
				hotbar.visible = true
			

func _on_paper_entered(body):
	if body.name == "Player":
		player_in_area = true
		

func _on_paper_exited(body):
	if body.name == "Player":
		player_in_area = false
		popup_layer.visible = false
		hotbar.visible = true
