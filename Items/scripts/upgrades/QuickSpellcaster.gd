extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/40_a.png")
	description="Become a quick spellcaster. Spells can be cast as quick as you can, without using up a turn.\n\n   +Quick Spellcasting"
	title="Quick Spells"

func onUse():
	GameData.player.spellUsesTurn = false
