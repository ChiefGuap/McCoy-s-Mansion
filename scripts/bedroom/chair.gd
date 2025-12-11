extends Interactable

@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var chair_sprite: Sprite2D = $ChairSprite 
@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

var player_in_area: bool = false
var chair_pushed_in: bool = false
const PUSHED_IN_POSITION: Vector2 = Vector2(0, -30)

func interact() -> void:
	pass

func _ready():
	turn_on_interactable()

func _on_chair_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_chair_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.vase_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "Who sat here?"
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
			
		if chair_pushed_in:
			return 
			
		player.lock_player()
		hotbar.visible = false
		
		box.visible = true
		label.visible = true
		box.size = Vector2(70, 25)
		label.add_theme_font_size_override("font_size", 7)
		label.modulate = Color(0, 0, 0, 1)

		label.text = "Pushed the chair!"
		Level3.chair_done = true
		chair_pushed_in = true
		self.position += PUSHED_IN_POSITION 
		
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file("res://WinScreen.tscn")
		label.text = "A door opened!"
		
		box.visible = false
		label.visible = false
		
		player.unlock_player()
		hotbar.visible = true
