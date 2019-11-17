extends TextureButton
var enabled = false
var representedSlot

func _pressed():
	if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen:
		GameData.player.setCurrentWeaponSlot(representedSlot)