extends Interactable

var player_in_area = false  # Tracks if player is inside the interaction zone

func _ready():
	# Ensure the outline is invisible (thickness 0) when the game starts
	turn_on_interactable()

func interact() -> void:
	pass

func _on_bottomredcouch_entered(body):
	if body.name == "Player":
		# Turn outline on by setting thickness to 1.0
		player_in_area = true
		

func _on_bottomredcouch_exited(body):
	if body.name == "Player":
		# Turn outline off
		player_in_area = false

func _process(delta):
	# Only check for E press when player is inside the area
	if player_in_area and Input.is_action_just_pressed("interact"):
		#jumpscare
		pass
