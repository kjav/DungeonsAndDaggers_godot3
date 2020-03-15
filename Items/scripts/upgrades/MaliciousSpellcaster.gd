extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/23_a.png")
	textureFilePath = "res://assets/23_a.png"
	description="Trained in cruel spells. Any spells that cause damage will now deal even more.\n\n  +Malicious Spellcasting"
	title="Cruel Spells"

func onUse():
	GameData.player.increasedSpellDamage = true
