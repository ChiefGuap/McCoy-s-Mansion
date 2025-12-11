extends Node

@export var success_label: Label 
@export var level3_barrier: Node2D

@onready var jumpscare_layer = $JumpscareLayer
@onready var scream_sound = $ScreamSound

@onready var table1 = $Table1
@onready var table2 = $Table2
@onready var table3 = $Table3
@onready var vase1 = %VaseBlue
@onready var vase2 = %VaseGolden
@onready var vase3 = %VaseWhite

@onready var player = $"../Player"

var hint_label: Label

var vases_dict = {}


func _ready() -> void:
	jumpscare_layer.visible = false
	success_label.visible = false
	hint_label = get_tree().root.find_child("LevelHintLabel", true, false)
	hint_label.visible = false
	
	if table1: table1.connect("add_vase", Callable(self, "add_vase_to_dict"))
	if table2: table2.connect("add_vase", Callable(self, "add_vase_to_dict"))
	if table3: table3.connect("add_vase", Callable(self, "add_vase_to_dict"))
	
	if vase1: vase1.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	if vase2: vase2.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	if vase3: vase3.connect("remove_vase", Callable(self, "remove_vase_from_dict"))


func enter_level() -> void:
	if hint_label:
		hint_label.visible = true
		hint_label.text = "HMMM, WHICH OF THESE CHAIRS COULD BE MCCOY'S?"
		get_tree().create_timer(5.0).timeout.connect(func(): hint_label.visible = false)


func add_vase_to_dict(table: Node2D, vase: Node2D) -> void:
	vases_dict[table] = vase
	
	if vases_dict.size() == 3:
		check_puzzle_solution()


func remove_vase_from_dict(vase: Node2D) -> void:
	for table in vases_dict.keys():
		if vases_dict[table] == vase:
			vases_dict.erase(table)
			table.vase = null
			break


func check_puzzle_solution():
	var is_correct = true
	
	if vases_dict.get(table1) != vase1:
		is_correct = false
	if vases_dict.get(table2) != vase2:
		is_correct = false
	if vases_dict.get(table3) != vase3:
		is_correct = false
	
	if is_correct:
		success_label.visible = true
		success_label.text = "THE BED ROOM DOOR CLICKS OPEN, ACROSS THE LIVING ROOM..."
		
		await get_tree().create_timer(4.0).timeout
		success_label.visible = false
		
		level3_barrier.queue_free()
	else:
		trigger_jumpscare()


func trigger_jumpscare() -> void:
	player.lock_player()
	
	# Call game_manager's timer penalty function
	get_tree().call_group("game_manager", "apply_jumpscare_penalty")
	
	scream_sound.play()
	
	# Visual Strobe Effect
	for i in range(5): 
		jumpscare_layer.visible = true
		await get_tree().create_timer(0.05).timeout
		jumpscare_layer.visible = false
		await get_tree().create_timer(0.05).timeout
		
	jumpscare_layer.visible = true
	await get_tree().create_timer(1.5).timeout
	jumpscare_layer.visible = false
	
	player.unlock_player()
