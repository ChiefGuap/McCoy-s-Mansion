extends Node2D

const START_TIME := 360 # this represents 6 minutes                
const LOW_TIME_THRESHOLD := 30 
const CRITICAL_TIME_THRESHOLD := 10  

var remaining_time_in_seconds := START_TIME
var _original_color: Color
var _pulse := 0.0

# this function is called when the scene first loads
func _ready():
	add_to_group("game_manager")  
	
	$CutsceneManager.play_intro_cutscene()
	_original_color = $UI_Layer/TimerLabel.modulate
	
	
	update_timer_label()


func _process(delta: float) -> void:
	if remaining_time_in_seconds <= CRITICAL_TIME_THRESHOLD and remaining_time_in_seconds > 0:
		_pulse += delta * 5.0
		var s := 1.0 + 0.05 * sin(_pulse)
		$UI_Layer/TimerLabel.scale = Vector2(s, s)
	else:
		_pulse = 0.0
		$UI_Layer/TimerLabel.scale = Vector2.ONE



func _on_timer_timeout():
	remaining_time_in_seconds -= 1

	# wwe are going to clamp it so basically it can't go negative
	if remaining_time_in_seconds <= 0:
		remaining_time_in_seconds = 0
		$UI_Layer/Timer.stop()
		update_timer_label()
		# game over when the timer hits zero
		get_tree().change_scene_to_file("res://GameOver.tscn")

	else:
		update_timer_label()


# this is the function of making the time look nice for the top left corner forb the game
func update_timer_label():
	var minutes = remaining_time_in_seconds / 60.0
	var seconds = remaining_time_in_seconds % 60
	
	$UI_Layer/TimerLabel.text = "%d:%02d" % [minutes, seconds]
	
	
	if remaining_time_in_seconds <= CRITICAL_TIME_THRESHOLD:
		# deep red when very low
		$UI_Layer/TimerLabel.modulate = Color(1, 0.2, 0.2)
	elif remaining_time_in_seconds <= LOW_TIME_THRESHOLD:
		# yellow warning
		$UI_Layer/TimerLabel.modulate = Color(1, 0.8, 0.4)
	else:
		# normal color
		$UI_Layer/TimerLabel.modulate = _original_color


#  jumpscare function to remove 30 seconds
func apply_jumpscare_penalty():
	remaining_time_in_seconds -= 30
	if remaining_time_in_seconds < 0:
		remaining_time_in_seconds = 0
	update_timer_label()
