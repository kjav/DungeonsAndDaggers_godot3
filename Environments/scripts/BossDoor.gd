extends "Door.gd"
signal bossDoorOpened()

func _ready():
	._ready()
	.emitBlockedStateChangeSignal(true)

func setLocked(_locked):
	walkable = Enums.WALKABLE.PLAYER
	.setLockedButNotWalkable(_locked)

func _init():
	environment_name = "BossDoor"
	blocksAttacks = true
	#place boss key somewhere

func onWalkedInto(character):
	if character == GameData.player:
		if !locked:
			setState("open")
			emit_signal("bossDoorOpened");
			blocksAttacks = false
		else:
			var key = GameData.HasKey(UnlockGuid)
			
			if key != null:
				keyUnlocked()
