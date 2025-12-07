extends Node

var vases_dict = {}
signal add_vase(tableNode, vaseNode)
signal remove_vase(vaseNode)

@onready var table1 = $Table1
@onready var table2 = $Table2
@onready var table3 = $Table3

@onready var vase1 = $VaseBlue
@onready var vase2 = $VaseGolden
@onready var vase3 = $VaseWhite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	table1.connect("add_vase", Callable(self, "add_vase_to_dict"))
	table2.connect("add_vase", Callable(self, "add_vase_to_dict"))
	table3.connect("add_vase", Callable(self, "add_vase_to_dict"))
	vase1.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	vase2.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	vase3.connect("remove_vase", Callable(self, "remove_vase_from_dict"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func add_vase_to_dict(table: Node2D, vase: Node2D) -> void:
	vases_dict[table] = vase
	
	if vases_dict.size() == 3:
		if (vases_dict[table1] != vase1 or vases_dict[table2] != vase2 or vases_dict[table3] != vase3):
			trigger_jumpscare()
		else:
			print("LEVEL 2 COMPLETE")

func remove_vase_from_dict(vase: Vase) -> void:
	print("HEREEEE")
	for table in vases_dict.keys():
		if vases_dict[table] == vase:
			vases_dict.erase(table)
			table.vase = null
			break

func trigger_jumpscare() -> void:
	print("Jumpscare")
	pass
