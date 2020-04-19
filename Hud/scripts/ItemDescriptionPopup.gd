extends Node2D

func hidePopup():
	hide()
	queue_free()

func setPopupPosition(mousePosition, position):
	var width = get_node("Background").get_global_transform().get_scale().x * get_node("Background").get_size().x - 50

	if position == "left":
		mousePosition.x -= width / 2
	elif position == "right":
		mousePosition.x += width / 2
	
	set_position(mousePosition)

func setItem(item):
	get_node("Name").text = item.item_name
	get_node("Description").text = item.item_description