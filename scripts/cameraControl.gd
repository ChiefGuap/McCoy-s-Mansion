extends Camera2D

var currCameraPos:int = 1

@onready var level_label: Label = get_tree().root.find_child("LevelNameLabel", true, false)

func _ready() -> void:
	level_label.text = "LIVING ROOM"
	pass 

func _on_diningRoomDoor_body_entered(body: PhysicsBody2D) -> void:
	if body.name != "Player":
		return

	var parent = get_parent()
	
	if (currCameraPos == 1):
		limit_left = 416
		limit_top = 64
		limit_right = 736
		limit_bottom = 280
		currCameraPos = 2
		parent.position = Vector2(450, 170)
		update_level_display("DINING ROOM")
	else:
		limit_left = 0
		limit_top = 0
		limit_right = 415
		limit_bottom = 276
		currCameraPos = 1
		parent.position = Vector2(380, 170)
		update_level_display("LIVING ROOM")

func _on_bedRoom_body_entered(body: PhysicsBody2D) -> void:
	# --- NEW: Add the check here too just in case ---
	if body.name != "Player":
		return
	# ------------------------------------------------

	var parent = get_parent()

	if currCameraPos == 1:
		# Switch to Bedroom (Room 3)
		limit_left = -270
		limit_top = -96
		limit_right = 1
		limit_bottom = 313
		currCameraPos = 3
		parent.position = Vector2(-30, 170)
		update_level_display("BED ROOM")

	else:
		# Switch back to Room 1
		limit_left = 0
		limit_top = 0
		limit_right = 415
		limit_bottom = 276
		currCameraPos = 1
		parent.position = Vector2(30, 170)
		update_level_display("LIVING ROOM")
	
		
func update_level_display(room_name: String) -> void:
	if level_label:
		level_label.text = room_name
