extends "SpellBase.gd"

func _init():
	textureFilePath = "res://assets/gem_spell.png"
	item_name = "Teleport"
	texture = preload("res://assets/gem_spell.png")

func onUse():		
	GameData.player.get_node("LightBlip").play("preparing")
	GameData.player.get_node("LightBlip").show()
	GameData.player.readyToTeleportOnTileSelect = true
	GameData.hud.SetVisibilityOfTeleportWarning(true)
	.onUse()
