extends "Door.gd"
signal bossDoorOpened()

func setLocked(_locked):
	walkable = Enums.WALKABLE.PLAYER
	.setLockedButNotWalkable(_locked)

func _init():
	environment_name = "BossDoor"
	#place boss key somewhere

func onWalkedInto(character):
	if character == GameData.player:
		if !locked:
			setState("open")
			emit_signal("bossDoorOpened");
		else:
			var key = GameData.HasKey(UnlockGuid)
			
			if key != null:
				keyUnlocked()
