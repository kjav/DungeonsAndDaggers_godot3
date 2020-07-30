extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/40_a.webp")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick spellcaster. Spells can be cast as quick as you can, without using up a turn.\n\n  +Quick Spellcasting"
	title="Quick Spells"

func onUse():
	GameData.player.spellUsesTurn = false
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.QuickSpellcasting)
