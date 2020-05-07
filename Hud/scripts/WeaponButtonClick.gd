extends "ItemPopupBaseScript.gd"
var representedSlot

func _init():
	popupPosition = "right"

func actionShortPress():
	if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen and getItem().equiptable:
		GameData.player.setCurrentWeaponSlot(representedSlot)

func getItem():
	return get_parent().get_parent().getWeapon(representedSlot)