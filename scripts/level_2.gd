extends Node

# --- CONNECTIONS ---
@onready var jumpscare_layer = $JumpscareLayer
@onready var scream_sound = $ScreamSound

# --- PUZZLE OBJECTS ---
@onready var table1 = $Table1
@onready var table2 = $Table2
@onready var table3 = $Table3

@onready var vase1 = $VaseBlue
@onready var vase2 = $VaseGolden
@onready var vase3 = $VaseWhite

var vases_dict = {}
var is_scaring = false

# Custom signals (if you are emitting them from children)
signal add_vase(tableNode, vaseNode)
signal remove_vase(vaseNode)

func _ready() -> void:
	# Ensure jumpscare is hidden at start
	if jumpscare_layer:
		jumpscare_layer.visible = false
	
	# Connect signals from tables/vases
	# (Assuming your child nodes emit these signals up to this script)
	if table1: table1.connect("add_vase", Callable(self, "add_vase_to_dict"))
	if table2: table2.connect("add_vase", Callable(self, "add_vase_to_dict"))
	if table3: table3.connect("add_vase", Callable(self, "add_vase_to_dict"))
	
	if vase1: vase1.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	if vase2: vase2.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	if vase3: vase3.connect("remove_vase", Callable(self, "remove_vase_from_dict"))

func add_vase_to_dict(table: Node2D, vase: Node2D) -> void:
	vases_dict[table] = vase
	print("Vase placed. Total on tables: ", vases_dict.size())
	
	# Check if all 3 tables are full
	if vases_dict.size() == 3:
		check_puzzle_solution()

func remove_vase_from_dict(vase: Node2D) -> void:
	print("Vase removed")
	for table in vases_dict.keys():
		if vases_dict[table] == vase:
			vases_dict.erase(table)
			# Assuming table has a 'vase' property to clear
			if "vase" in table:
				table.vase = null
			break

func check_puzzle_solution():
	# WIN CONDITION:
	# VaseBlue (vase1) on Table1
	# VaseGolden (vase2) on Table2
	# VaseWhite (vase3) on Table3
	
	var is_correct = true
	
	if vases_dict.get(table1) != vase1: is_correct = false
	if vases_dict.get(table2) != vase2: is_correct = false
	if vases_dict.get(table3) != vase3: is_correct = false
	
	if is_correct:
		print("✅ LEVEL 2 COMPLETE")
		# Add code here to open the door or transition level
	else:
		print("❌ WRONG ORDER! TRIGGERING JUMPSCARE...")
		trigger_jumpscare()

func trigger_jumpscare() -> void:
	if is_scaring: return
	is_scaring = true
	
	# 1. Apply Penalty (Optional)
	get_tree().call_group("game_manager", "apply_jumpscare_penalty")
	
	# 2. Play Sound
	if scream_sound:
		scream_sound.play()
	
	# 3. Visual Strobe Effect
	if jumpscare_layer:
		# Flash 5 times quickly
		for i in range(5): 
			jumpscare_layer.visible = true
			await get_tree().create_timer(0.05).timeout
			jumpscare_layer.visible = false
			await get_tree().create_timer(0.05).timeout
		
		# Hold face on screen
		jumpscare_layer.visible = true
		await get_tree().create_timer(1.5).timeout
		jumpscare_layer.visible = false
	
	# 4. Reset Logic (Optional: Knock vases off tables?)
	is_scaring = false
	print("Jumpscare finished. Try again.")
