extends Node2D

func hidePopup():
	hide()
	queue_free()

func setPopupPosition(mousePosition):
	set_position(mousePosition)

func setItem(item):
	get_node("Name").text = item.item_name
	get_node("Description").text = item.item_description