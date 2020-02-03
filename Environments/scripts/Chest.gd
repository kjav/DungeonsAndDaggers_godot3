tool
extends "UnlockableBase.gd"

var item_distribution

func _init():
	environment_name = "Chest"
	walkable = Enums.WALKABLE.NONE
	blocksAttacks = true

func handleAnimation():
	var state
	
	if locked:
		state = "closed"
	else:
		state = "open"
	
	self.set_animation(state)

func setLocked(_locked):
	.setLockedButNotWalkable(_locked)
	handleAnimation();

func keyUnlocked():
	.keyUnlocked()

func setDistribution(_distribution):
	item_distribution = _distribution

func remove():
	if(item_distribution != null):
		for item in item_distribution.pick():
			item.value.new().place(get_position())
	
	.remove()

func onWalkedInto(character):
	if !locked:
		remove()
	
	if GameData.chosen_map == "Tutorial":
		GameData.hud.get_node("TutorialTextPrompts").get_child(0).set_text("Some\nweapons have\nlimited ammo\nOr attack\nover distance")
		GameData.hud.get_node("TutorialTextPrompts").get_child(0).set_position(Vector2(4.2, 10.1) * GameData.TileSize)
	
	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()
