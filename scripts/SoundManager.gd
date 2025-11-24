extends Node
# File by Pranshu J

# Configure audio buses (optional, can use "Master" if you want)
var music_bus := "Music"
var sfx_bus := "SFX"

var ambient_player: AudioStreamPlayer
var sfx_player: AudioStreamPlayer
var ui_player: AudioStreamPlayer
var jumpscare_player: AudioStreamPlayer
var boss_player: AudioStreamPlayer
var tick_player: AudioStreamPlayer

func _ready():
	# Create audio players dynamically
	ambient_player = AudioStreamPlayer.new()
	sfx_player = AudioStreamPlayer.new()
	ui_player = AudioStreamPlayer.new()
	jumpscare_player = AudioStreamPlayer.new()
	boss_player = AudioStreamPlayer.new()
	tick_player = AudioStreamPlayer.new()

	# Assign buses
	ambient_player.bus = music_bus
	sfx_player.bus = sfx_bus
	ui_player.bus = sfx_bus
	jumpscare_player.bus = sfx_bus
	boss_player.bus = sfx_bus
	tick_player.bus = sfx_bus

	# Add players as children to the root
	add_child(ambient_player)
	add_child(sfx_player)
	add_child(ui_player)
	add_child(jumpscare_player)
	add_child(boss_player)
	add_child(tick_player)


# ---------------------------------------------------
# SOUND PLAYING METHODS
# ---------------------------------------------------

func play_sfx(path: String):
	var sound = load(path)
	if sound:
		sfx_player.stream = sound
		sfx_player.volume_db = +4
		sfx_player.play()


func play_ui(path: String):
	var sound = load(path)
	if sound:
		ui_player.stream = sound
		ui_player.play()


func play_ambient(path: String):
	var sound: AudioStream = load(path)
	if sound:
		# Enable looping if supported
		if sound.has_method("set_loop"):
			sound.set_loop(true)
		
		elif sound.has_property("loop"):
			sound.loop = true
			
		ambient_player.stream = sound
		ambient_player.volume_db = -8
		ambient_player.play()


func stop_ambient():
	ambient_player.stop()


func play_jumpscare(path: String):
	var sound = load(path)
	if sound:
		jumpscare_player.stream = sound
		jumpscare_player.volume_db = 6  # louder impact
		jumpscare_player.play()


func play_boss(path: String):
	var sound = load(path)
	if sound:
		boss_player.stream = sound
		boss_player.play()


func stop_boss():
	boss_player.stop()


func play_tick(path: String):
	var sound = load(path)
	if sound:
		tick_player.stream = sound
		tick_player.play()
