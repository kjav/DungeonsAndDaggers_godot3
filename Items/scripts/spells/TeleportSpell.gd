extends "SpellBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/gem_spell.webp"
	item_name = "Teleport"
	item_description = "Allows you to teleport to a chosen tile."
	texture = preload("res://assets/gem_spell.webp")

func onUse():
	GameData.player.get_node("LightBlip").play("preparing")
	GameData.player.get_node("LightBlip").show()
	GameData.player.readyToTeleportOnTileSelect = true
	GameData.hud.SetVisibilityOfTeleportWarning(true)
	.onUse()
