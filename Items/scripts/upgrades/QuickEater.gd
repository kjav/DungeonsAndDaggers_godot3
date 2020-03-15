extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/40_a.png")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick eater. Food can be eaten as quick as you can click, without using up a turn.\n\n  +Quick Eating"
	title="Quick Eating"

func onUse():
	GameData.player.foodUsesTurn = false
