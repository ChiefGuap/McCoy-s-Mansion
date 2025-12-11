extends Interactable

@onready var box = $"../../Player/DialougeBox"
@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var player = $"../../Player"
@onready var hotbar = $"../../UI_Layer/Hotbar"

@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

var player_in_area = false  

func _ready():
	turn_on_interactable()

func interact() -> void:
	pass

func _on_bottomredcouch_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_bottomredcouch_exited(body):
	if body.name == "Player":
		player_in_area = false

func _process(delta):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if randf() < .60:
			box.visible = true
			label.visible = true
			label.text = "Fancy couch!"
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
