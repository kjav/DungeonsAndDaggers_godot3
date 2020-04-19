extends "ItemPopupBaseScript.gd"
var enabled = false
var representedSlot

func actionShortPress():
	if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen:
		GameData.player.setCurrentWeaponSlot(representedSlot)

func getItem():
	return get_parent().get_parent().getWeapon(representedSlot)