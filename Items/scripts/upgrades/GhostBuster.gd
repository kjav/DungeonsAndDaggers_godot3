extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/06_a.webp")
	textureFilePath = "res://assets/06_a.webp"
	description="Ghosts can't hide from you, be able to damage them even on turns they would be invulnerable.\n\n  +Ghost Buster Effect"
	title="Ghost Buster"

func onUse():
	GameData.player.canAlwaysHurtGhosts = true
	GameData.hud.get_node("HudCanvasLayer/StatusEffects").addEffect(Constants.StatusEffects.GhostBuster)
