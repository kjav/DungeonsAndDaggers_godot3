extends "UpgradeBase.gd"

func _init():
	texture = preload("res://assets/17_a.png")
	textureFilePath = "res://assets/17_a.png"
	description="Ghosts can't hide from you, be able to damage them even on turns they would be invulnerable.\n\n  +Stop Ghost Invulnerability"
	title="Ghost Buster"

func onUse():
	GameData.player.canAlwaysHurtGhosts = true
