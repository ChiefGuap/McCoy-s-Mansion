extends Interactable

var unlocked := false
@onready var note: Note = $Note
var displaying_note := false

func _ready() -> void:
	turn_on_interactable()


func interact() -> void:
	if displaying_note:
		displaying_note = false
		note.make_invisible()
		return
	
	if unlocked:
		displaying_note = true
		note.make_visible()
		unlocked = true
		return
	
	var hotbar = get_tree().root.find_child("Hotbar", true, false)
	var item: Node2D = hotbar.get_held_item()
	if (item != null and item is Key):
		DisplayDialouge.new().display_dialouge("A note.")
		displaying_note = true
		note.make_visible()
		hotbar.remove_from_hotbar(item)
		unlocked = true
	else:
		DisplayDialouge.new().display_dialouge("This drawer \nis locked")


# Extend turn_off_outline so when you walk away from the drawer collision, the note disappears
func turn_off_outline() -> void:
	displaying_note = false
	note.make_invisible()
	super()
