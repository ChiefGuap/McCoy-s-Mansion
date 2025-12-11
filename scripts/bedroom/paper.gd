extends Interactable

@onready var paper = $PaperSprite
var player_in_area = false  
@onready var popup_layer = $Original
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var bottle = $"../Bottle"
@onready var torch = $"../Torch"
@onready var dirty = $Original/ColorRect
@onready var blue = $Original/Blue

var checked = false

func _ready():
	popup_layer.visible = false
	turn_on_interactable()

func interact() -> void:
	pass

func _input(event):
	if event.is_action_pressed("interact") and player_in_area:
		var item = hotbar.get_held_item()
		print(item)
		if item == bottle:
			hotbar.remove_from_hotbar(item)
			dirty.visible = false
		if item == torch and !dirty.visible:
			blue.visible = false
			checked = true
			Level3.paper_done = true
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
