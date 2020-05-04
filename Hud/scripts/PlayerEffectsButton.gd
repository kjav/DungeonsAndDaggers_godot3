extends TextureButton

var clickInProgress = false
const ItemDescriptionPopup = preload("res://Hud/ItemDescriptionPopup.tscn")

func _input(event):
	if !clickInProgress and get_parent().effectDescription != null and event.is_action_pressed("click") and withinTileBounds(event.position):
		clickInProgress = true
		
		var new_instance = ItemDescriptionPopup.instance()
		new_instance.set_name("ItemDescriptionPopup")
		new_instance.setTitleAndDescription(get_parent().effectName, get_parent().effectDescription)
		new_instance.setPopupPosition(event.position, "left")
		GameData.hud.get_node("HudCanvasLayer/Popups").add_child(new_instance)
	elif event.is_action_released("click") and clickInProgress:
		clickInProgress = false
		
		for node in GameData.hud.get_node("HudCanvasLayer/Popups").get_children():
		    node.hidePopup()

func withinTileBounds(pos):
	var size = self.get_global_transform().get_scale() * self.get_size()
	
	return pos.x > self.get_global_position().x and pos.x < self.get_global_position().x + size.x and pos.y > self.get_global_position().y and pos.y < self.get_global_position().y + size.y
