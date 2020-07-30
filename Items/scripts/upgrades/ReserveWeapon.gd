extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/17_a.webp")
	textureFilePath = "res://assets/17_a.webp"
	description="Take another weapon with you. Offhand weapon abilities do not stack.\n\n  +Additional Weapon Slot"
	title="More Weapons"

func onUse():
	GameData.player.thirdWeaponSlot = true
	GameData.hud.get_node("HudCanvasLayer/WeaponSlots/Tertiary Weapon").visible = GameData.player.thirdWeaponSlot
