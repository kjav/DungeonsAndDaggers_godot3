extends Node2D

func hidePopup():
	hide()
	queue_free()

func setPopupPosition(mousePosition, position):
	var width = get_node("Background").get_global_transform().get_scale().x * get_node("Background").get_size().x

	if position == "left":
		mousePosition.x -= width / 2
	elif position == "right":
		mousePosition.x += width / 2
	
	set_position(mousePosition)

func setItem(item):
	setTitleAndDescription(item.item_name, item.item_description)

func setTitleAndDescription(nameText, descriptionText):
	if not nameText:
		return false
	if is_instance_valid(get_node("Name")):
		get_node("Name").text = nameText
	if is_instance_valid(get_node("Description")):
		get_node("Description").text = descriptionText
	
	show()
	
	if (nameText == null and descriptionText == null):
		hidePopup()
