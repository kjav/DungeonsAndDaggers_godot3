tool
extends "UnlockableBase.gd"

var item_distribution

func _init():
	name = "Chest"
	walkable = true

func handleAnimation():
	var state
	
	if locked:
		state = "closed"
	else:
		state = "open"
	
	self.set_animation(state)

func setLocked(_locked):
	.setLocked(_locked)
	handleAnimation();

func keyUnlocked():
	.keyUnlocked()

func setDistribution(_distribution):
	item_distribution = _distribution

func remove():
	if(item_distribution != null):
		var item = item_distribution.pick()[0].new()
		item.place(get_position())
	
	.remove()

func onWalkedInto(character):
	if !locked:
		remove()
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()
