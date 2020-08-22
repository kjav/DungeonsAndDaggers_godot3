extends "UpgradeBase.gd"

func _init():
	._init()
	texture = preload("res://assets/40_a.webp")
	textureFilePath = "res://assets/40_a.webp"
	description="Become a quick spellcaster. The first spell you cast on a turn will not end it.\n\n  +Quick Spellcasting"
	title="Quick Spells"

func onUse():
	GameData.player.firstSpellTurnFree = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.QuickSpellcasting)
