extends TextureButton
const InventoryType = preload("res://Hud/Inventory.tscn")

var tutorial_arrow_shown = false
func _pressed():
	if not get_tree().get_current_scene().get_node("HudNode").inventoryOpen:
		#Audio.playSoundEffect("Inventory_Open",true)
		get_tree().get_current_scene().get_node("HudNode").inventoryOpen = true
		var new_inventory_instance = InventoryType.instance()
		new_inventory_instance.setType(self.get_parent().getType())  
		new_inventory_instance.set_name("Inventory")
		get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").add_child(new_inventory_instance)
		new_inventory_instance.populateInventory()
		get_tree().get_current_scene().get_node("HudNode/HudCanvasLayer/FoodInvent/TutorialArrow").hide()
		if GameData.chosen_map == "Tutorial" and not tutorial_arrow_shown:
			tutorial_arrow_shown = true
			new_inventory_instance.get_node("InventoryWrapperTop/TutorialArrow").show()
