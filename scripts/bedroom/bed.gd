extends Interactable

@onready var bedsprite = $BedSprite
var player_in_area = false 
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var popup: = $Original

var popup_available: bool = false 
var popup_is_open: bool = false

@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

func _ready():
	turn_on_interactable()
	popup.visible = false

func interact() -> void:
	pass

func _on_bed_entered(body):
	if body.name == "Player":
		player_in_area = true
		

func _on_bed_exited(body):
	if body.name == "Player":
		player_in_area = false
		if popup_is_open:
			toggle_popup_display()


func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.clock_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "Looks Comfy"
				await get_tree().create_timer(2.0).timeout
				box.visible = false
				label.visible = false
				return
			else:
				player.lock_player()
				hotbar.visible = false
				jumpscare_layer.visible = true
				scream_sound.play()
				
				for i in 5:
					await get_tree().create_timer(0.05).timeout
					jumpscare_layer.visible = false
					await get_tree().create_timer(0.05).timeout
					jumpscare_layer.visible = true
					
				await get_tree().create_timer(1.5).timeout 
				jumpscare_layer.visible = false
				
				player.unlock_player()
				hotbar.visible = true
				return
		
		if popup_available:
			toggle_popup_display()
			return 
		
		player.lock_player()
		hotbar.visible = false
		
		if player.position.y > 90 and player.position.y < 120 and player.position.x > -240 and player.position.x < -220:
			box.visible = true
			label.visible = true
			box.size = Vector2(70, 25)
			label.add_theme_font_size_override("font_size", 7)
			label.modulate = Color(0, 0, 0, 1)

			label.text = "Something's here!"
			await get_tree().create_timer(2.0).timeout
			box.visible = false
			label.visible = false
			
			popup_available = true 
			Level3.bed_done = true
			toggle_popup_display() 
		else:
			box.visible = true
			label.visible = true
			box.size = Vector2(70, 25)
			label.add_theme_font_size_override("font_size", 8)
			label.modulate = Color(0, 0, 0, 1)

			label.text = "Nothing's here!"
			await get_tree().create_timer(2.0).timeout
			box.visible = false
			label.visible = false
			player.unlock_player() 

func toggle_popup_display() -> void:
	popup.visible = not popup.visible
	popup_is_open = popup.visible

	if popup_is_open:
		player.lock_player()
		hotbar.visible = false
	else:
		player.unlock_player()
		hotbar.visible = true
