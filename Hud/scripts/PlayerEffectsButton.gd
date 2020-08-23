extends "ItemPopupBaseScript.gd"

func _init().():
	longPressTime = 0
	popupPosition = "left"

func withinTileBounds(pos):
	var size = self.get_global_transform().get_scale() * self.get_size()
	
	return pos.x > self.get_global_position().x and pos.x < self.get_global_position().x + size.x and pos.y > self.get_global_position().y and pos.y < self.get_global_position().y + size.y

func getTitle():
	return get_parent().effectName

func getDescription():
	return get_parent().effectDescription
