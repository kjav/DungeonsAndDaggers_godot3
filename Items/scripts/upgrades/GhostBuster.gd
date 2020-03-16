extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/06_a.webp")
	textureFilePath = "res://assets/06_a.webp"
	description="Ghosts can't hide from you, be able to damage them even on turns they would be invulnerable.\n\n  +Stop Ghost Invulnerability"
	title="Ghost Buster"

func onUse():
	GameData.player.canAlwaysHurtGhosts = true
