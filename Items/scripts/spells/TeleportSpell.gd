extends "SpellBase.gd"

func _init():
	iconFilePath = "res://assets/gem_spell.webp"
	item_name = "Teleport"
	texture = preload("res://assets/gem_spell.webp")

func onUse():		
	.onUse()
	GameData.player.get_node("LightBlip").play("preparing")
	GameData.player.get_node("LightBlip").show()
	GameData.player.readyToTeleportOnTileSelect = true
	GameData.hud.SetVisibilityOfTeleportWarning(true)
