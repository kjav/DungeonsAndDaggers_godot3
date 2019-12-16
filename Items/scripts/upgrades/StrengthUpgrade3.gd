extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/37_a.png")
	description="Increases your strength level, making you hit more consistently.\n\n   +3 strength"
	title="Berserker"

func onUse():
	GameData.player.increaseStat("strength", 3)
