extends "UnlockableBase.gd"

export(String, "side", "front") var facing = "front" setget setFacing, getFacing
export(String, "closed", "open") var state = "closed" setget setState, getState

var front_closed = preload("res://assets/floor_tiles/old castle/Door 2.png")
var front_closed_n = preload("res://assets/floor_tiles/old castle/Door 2_n.png")
var front_open = preload("res://assets/floor_tiles/old castle/Door 2_open.png")
var front_open_n = preload("res://assets/floor_tiles/old castle/Door 2_open_n.png")

var side_closed = preload("res://assets/floor_tiles/old castle/DoorTopVertical.png")
var side_closed_n = preload("res://assets/floor_tiles/old castle/DoorTopVertical_n.png")
var side_open = preload("res://assets/floor_tiles/old castle/DoorTopVertical_open.png")
var side_open_n = preload("res://assets/floor_tiles/old castle/DoorTopVertical_open_n.png")

func _init():
	environment_name = "Door"
	blocksAttacks = true

func _ready():
	var randomNumber = randi()%20
	get_node("Torches/Torch").visible = randomNumber == 0
	get_node("Torches/Torch2").visible = randomNumber == 1
	
	._ready()

func handleAnimation():
	if facing == "side":
		if state == "closed":
			get_node("door_sprite").texture = side_closed
			get_node("door_sprite").normal_map = side_closed_n
		else:
			get_node("door_sprite").texture = side_open
			get_node("door_sprite").normal_map = side_open_n
	else:
		if state == "closed":
			get_node("door_sprite").texture = front_closed
			get_node("door_sprite").normal_map = front_closed_n
		else:
			get_node("door_sprite").texture = front_open
			get_node("door_sprite").normal_map = front_open_n
	if facing == "front":
		if state == "open":
			get_node("Top_open").show()
			get_node("Top_closed").hide()
		else:
			get_node("Top_open").hide()
			get_node("Top_closed").show()
	else:
		get_node("Top_open").hide()
		get_node("Top_closed").hide()

func changeOfState(original, new):
	return original != new

func setFacing(_facing):
	if typeof(_facing) == TYPE_STRING:
		if changeOfState(facing, _facing):
			facing = _facing
			
			handleAnimation()
			
			if get_node("Locks") != null:
				get_node("Locks").set_animation(facing + "_locked")
			if facing == "front":
				get_node("Torches").show()
			else:
				get_node("Torches").hide()

func getFacing():
	return facing

func setState(_state):
	if typeof(_state) == TYPE_STRING:
		if changeOfState(state, _state):
			state = _state
			handleAnimation()

func getState():
	return state

func setLocked(_locked):
	.setLocked(_locked)
	handleAnimation()

func keyUnlocked():
	setLocked("false")
	.keyUnlocked()
	handleAnimation()

func reset():
	setFacing(facing)
	setLocked(locked)

func onWalkedInto(character):
	if !locked:
		setState("open")
		blocksAttacks = false
		
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 1:
			GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_text("You can also\nclick on a\ntile to move.")
			GameData.hud.get_node("TutorialTextPrompts").get_child(3).set_position(Vector2(5.2, 4.1) * GameData.TileSize)
			
			GameData.addTutorialTextIfTutorial("You can find out\nwhat an item\n does by long\npressing on it\nin the inventory\nafter picking it up.", Vector2(7.8, 1))
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()

