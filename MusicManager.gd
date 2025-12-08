extends Node

@onready var player := AudioStreamPlayer.new()

func _ready():
	# Add audio player to this Node
	add_child(player)
	
	# Load your MP3
	var stream := load("res://assets/world_scene/horror-background-atmosphere-for-suspense-166944.mp3")
	
	player.stream = stream
	
	# Enable looping on the stream itself
	if stream is AudioStream:
		stream.loop = true
	
	player.volume_db = -8   # softer, adjust as needed
	player.play()
