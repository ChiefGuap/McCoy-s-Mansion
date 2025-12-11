extends Interactable

@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var popup = $Original

@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

var vase_broken: bool = false 
var clue_is_open: bool = false 
var player_in_area: bool = false 

func _ready():
	turn_on_interactable()
	popup.visible = false

func interact() -> void:
	pass

func _on_vase_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_vase_exited(body):
	if body.name == "Player":
		player_in_area = false
		if clue_is_open:
			toggle_clue_display()

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.bed_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				player.lock_player()
				label.text = "What's inside?"
				await get_tree().create_timer(2.0).timeout 
				
				label.text = "Hands won't fit"
				await get_tree().create_timer(2.0).timeout 
				player.unlock_player()
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
			
		if vase_broken:
			toggle_clue_display()
			return 
		
		player.lock_player()
		hotbar.visible = false
		
		box.visible = true
		label.visible = true
		box.size = Vector2(70, 25)
		label.add_theme_font_size_override("font_size", 7)
		label.modulate = Color(0, 0, 0, 1)

		label.text = "You hit the vase!"
		vase_broken = true
		Level3.vase_done = true
		
		await get_tree().create_timer(3.0).timeout 
		label.text = "It shatters"
		await get_tree().create_timer(2.0).timeout
		label.text = "Inside's a note"
		await get_tree().create_timer(2.0).timeout
		
		box.visible = false
		label.visible = false
		toggle_clue_display() 

func toggle_clue_display() -> void:
	popup.visible = not popup.visible
	clue_is_open = popup.visible

	if clue_is_open:
		player.lock_player()
		hotbar.visible = false
		print("Clue opened. Player locked.")
	else:
		player.unlock_player()
		hotbar.visible = true
		global_position = Vector2(1000, 1000)
		self.visible = false
		print("Clue closed. Player unlocked.")
