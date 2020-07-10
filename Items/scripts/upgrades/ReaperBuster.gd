extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/06_a.webp")
	textureFilePath = "res://assets/06_a.webp"
	description="Reapers can't hide from you, be able to damage them even on turns they would be invulnerable.\n\n  +Reaper Buster"
	title="Reaper Buster"

func onUse():
	GameData.player.canAlwaysHurtReapers = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.ReaperBuster)
