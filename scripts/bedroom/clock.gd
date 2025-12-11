extends Interactable

@onready var label = $"../../Player/DialougeBox/DialougeText"
@onready var box = $"../../Player/DialougeBox"
@onready var input_popup_layer = $CanvasLayer 
@onready var hotbar = $"../../UI_Layer/Hotbar"
@onready var player = $"../../Player"
@onready var input_field: LineEdit = $CanvasLayer/NinePatchRect2/LineEdit
@onready var note_popup_layer: CanvasLayer = $note

@onready var jumpscare_layer: CanvasLayer = $JumpscareLayer
@onready var scream_sound: AudioStreamPlayer2D = $ScreamSound

var current_time: String = "06:09" 
var waiting_for_input: bool = false 
var note_unlocked: bool = false 
var player_in_area: bool = false 


func interact() -> void:
	pass
	
func _ready():
	input_popup_layer.visible = false
	note_popup_layer.visible = false 
	input_field.editable = true
	input_field.text_submitted.connect(_on_time_input_submitted)
	turn_on_interactable()

func _process(delta: float):
	if player_in_area and Input.is_action_just_pressed("interact"):
		if !Level3.paper_done:
			if randf() < .60:
				box.visible = true
				label.visible = true
				label.text = "The time's wrong"
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
		if note_unlocked:
			toggle_note_display()
			return 
		if not waiting_for_input:
			start_time_prompt()

func toggle_note_display():
	note_popup_layer.visible = not note_popup_layer.visible
	if note_popup_layer.visible:
		player.lock_player()
		hotbar.visible = false
	else:
		player.unlock_player()
		hotbar.visible = true

func start_time_prompt():
	player.lock_player()
	hotbar.visible = false
	waiting_for_input = true
	
	box.visible = true
	label.visible = true
	box.size = Vector2(70, 25)
	label.add_theme_font_size_override("font_size", 7)
	label.modulate = Color(0, 0, 0, 1)
	label.text = "The time is " + current_time

	await get_tree().create_timer(2.0).timeout
	
	label.text = "Enter new time:"
	
	input_popup_layer.visible = true
	input_field.text = ""
	input_field.grab_focus() 

func _on_time_input_submitted(submitted_text: String):
	if not waiting_for_input: return
	input_field.release_focus()

	if submitted_text.length() != 4 or not submitted_text.is_valid_int():
		label.text = "Invalid format. Use HHMM."
		input_field.clear()
		await get_tree().create_timer(1.5).timeout
		input_field.grab_focus() 
		return

	var input_time_int = submitted_text.to_int()
	var hours = input_time_int / 100
	var minutes = input_time_int % 100
	
	if hours > 23 or minutes > 59:
		label.text = "Time must be 0000-2359."
		input_field.clear()
		await get_tree().create_timer(1.5).timeout
		input_field.grab_focus()
		return

	current_time = "%02d:%02d" % [hours, minutes]
	label.text = "Time set to " + current_time + "."

	if current_time == "06:07":
		input_popup_layer.visible = false
		await get_tree().create_timer(2).timeout
		label.text = "The clock chimes"
		await get_tree().create_timer(2).timeout
		label.text = "A note appeared!"
		note_unlocked = true 
		Level3.clock_done = true
	
	await get_tree().create_timer(0.5).timeout
	end_input_interaction()


func end_input_interaction():
	input_popup_layer.visible = false
	box.visible = false
	label.visible = false
	
	player.unlock_player()
	hotbar.visible = true
	waiting_for_input = false

func _on_clock_entered(body):
	if body.name == "Player":
		player_in_area = true

func _on_clock_exited(body):
	if body.name == "Player":
		player_in_area = false
		if waiting_for_input:
			end_input_interaction()
		if note_popup_layer.visible:
			toggle_note_display()
