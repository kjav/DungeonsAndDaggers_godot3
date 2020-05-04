extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/23_a.webp")
	textureFilePath = "res://assets/23_a.webp"
	description="Trained in cruel spells. Any spells that cause damage will now deal even more.\n\n  +Malicious Spellcasting"
	title="Cruel Spells"

func onUse():
	GameData.player.increasedSpellDamage = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.MaliciousSpellcaster)
