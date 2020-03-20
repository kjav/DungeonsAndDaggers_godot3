extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/15_a.webp")
	textureFilePath = "res://assets/15_a.webp"
	description="Learn to be more versatile. Unlock the third upgrade slot.\n\n  +Additional Upgrade Slot"
	title="Versatile"

func onUse():
	GameData.player.thirdUpgradeSlot = true
