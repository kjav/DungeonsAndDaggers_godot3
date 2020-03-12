extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/31_a.png")
	description="Become immune to all traps, you will be able to walk over spike traps unharmed.\n\n   +Trap Immune"
	title="Trap Immunity"

func onUse():
	GameData.player.trapImmune = true
