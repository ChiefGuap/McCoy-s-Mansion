extends Camera2D

var currCameraPos:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_diningRoomDoor_body_entered(body: PhysicsBody2D) -> void:
	var parent = get_parent()
	
	if (currCameraPos == 1):
		limit_left = 416
		limit_top = 64
		limit_right = 750
		limit_bottom = 256
		currCameraPos = 2
		parent.position = Vector2(450, 176)
	else:
		limit_left = 0
		limit_top = 0
		limit_right = 415
		limit_bottom = 256
		currCameraPos = 1
		parent.position = Vector2(380, 176)
		


func _on_bedRoom_body_entered(body: PhysicsBody2D) -> void:
	var parent = get_parent()

	if currCameraPos == 1:
		# Switch to Bedroom (Room 3)
		limit_left = -255
		limit_top = -100
		limit_right = 1
		limit_bottom = 291
		currCameraPos = 3
		parent.position = Vector2(-30, 176)

	else:
		# Switch back to Room 1
		limit_left = 0
		limit_top = 0
		limit_right = 415
		limit_bottom = 256
		currCameraPos = 1
		parent.position = Vector2(30, 176)
