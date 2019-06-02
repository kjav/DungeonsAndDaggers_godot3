extends "Door.gd"

func _init():
	environment_name = "BossDoor"
	#place boss key somewhere

func onWalkedInto(character):
	if !locked && character == GameData.player:
		setState("open")
		#reset boss room(s)
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()
