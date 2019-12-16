extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/28_a.png")
	description="Increases your total hitpoints, so you will last longer in battle.n\n   +1 Hitpoints"
	title="Constitution"

func onUse():
	GameData.player.increaseMaxHealth(1)
	GameData.player.heal(1)
