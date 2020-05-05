extends "UnlockableBase.gd"

export(String, "side", "front") var facing = "front" setget setFacing, getFacing
export(String, "closed", "open") var state = "closed" setget setState, getState

func _init():
	environment_name = "Door"
	blocksAttacks = true

func handleAnimation():
	self.set_animation(facing + "_" + state)
	if facing == "front" and state == "closed":
		get_node("Top").show()
	else:
		get_node("Top").hide()

func changeOfState(original, new):
	return original != new

func setFacing(_facing):
	if typeof(_facing) == TYPE_STRING:
		if changeOfState(facing, _facing):
			facing = _facing
			
			handleAnimation()
			
			if get_node("Locks") != null:
				get_node("Locks").set_animation(facing + "_locked")

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
			
			GameData.addTutorialTextIfTutorial("You can find out\nwhat an item or\nweapon does by long\npressing on it in\nthe inventory.", Vector2(7.8, 1))
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()

