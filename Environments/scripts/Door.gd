extends "UnlockableBase.gd"

export(String, "side", "front") var facing = "front" setget setFacing, getFacing
export(String, "closed", "open") var state = "closed" setget setState, getState

func _init():
	environment_name = "Door"
	blocksAttacks = true

func handleAnimation():
	self.set_animation(facing + "_" + state)

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
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()
