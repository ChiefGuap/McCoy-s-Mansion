extends CharacterBody2D

const DEFAULT_MOVE_VELOCITY = 150
var movement_speed = DEFAULT_MOVE_VELOCITY

@onready var step_timer: Timer = $StepTimer

# Added by Pranshu J
var footstep_sounds = [
	"res://assets/audio/footsteps/Wood_footsteps.ogg",
    "res://assets/audio/footsteps/Concrete_footsteps.ogg"
]

func _ready() -> void:
	position.x = 100
	position.y = 100
	$AnimatedSprite2D.play()

func _process(delta: float) -> void:
	var direction = Vector2.ZERO

	# By Pranshu J
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		$AnimatedSprite2D.flip_h = false
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1

	if direction != Vector2.ZERO:
		velocity = direction.normalized() * movement_speed
		$AnimatedSprite2D.animation = "run"
	else:
		velocity = Vector2.ZERO
		$AnimatedSprite2D.animation = "default"

	# Added By Pranshu J
	if direction != Vector2.ZERO:
		if step_timer.is_stopped():
			var sound_path = footstep_sounds[randi() % footstep_sounds.size()]
			SoundManager.sfx_player.pitch_scale = randf_range(0.95, 1.05)
			SoundManager.play_sfx(sound_path)
			step_timer.start()
	else:
		# Stop any footstep playing if the player stops moving
		SoundManager.sfx_player.stop()
		step_timer.stop()
		SoundManager.sfx_player.pitch_scale = 1.0

	_apply_movement()

func _apply_movement() -> void:
	move_and_slide()
