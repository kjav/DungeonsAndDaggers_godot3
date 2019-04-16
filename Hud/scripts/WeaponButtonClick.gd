extends TextureButton

func _pressed():
	if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen:
		GameData.player.swapWeapons()
		
		if (get_parent().getFrameStyle() == "Blue"):
			get_parent().setFrameStyle("Pink")
		else:
		 	get_parent().setFrameStyle("Blue")
