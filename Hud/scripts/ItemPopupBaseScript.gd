extends TextureButton

const ItemDescriptionPopup = preload("res://Hud/ItemDescriptionPopup.tscn")
var popupAdded = false
var clickInProgress = false
var pressStartTime = OS.get_ticks_msec()
var mousePosition = Vector2(9999,9999)
var popupPosition = "center"
var longPressTime = 150
var popupContainer

func _ready():
	if is_instance_valid(GameData.hud):
		if GameData.hud != null:
			popupContainer = GameData.hud.get_node("HudCanvasLayer/Popups")
		else:
			popupContainer = get_node("../../Popups")

func actionShortPress():
	pass

func getItem():
	pass
	
func getTitle():
	pass

func getDescription():
	pass

func _input(event):
	if not is_instance_valid(popupContainer):
		return false
	
	if !clickInProgress and event.is_action_pressed("click"):
		for node in popupContainer.get_children():
			node.hidePopup()
	
	if !clickInProgress and event.is_action_pressed("click") and withinTileBounds(event.position):
		pressStartTime = OS.get_ticks_msec()
		popupAdded = false
		clickInProgress = true
		mousePosition = event.position
	elif clickInProgress and event.is_action_released("click") and withinTileBounds(mousePosition):
		if popupAdded:
			popupAdded = false
			clickInProgress = false
			mousePosition = Vector2(9999,9999)
		elif !isLongPress():
			actionShortPress()
			popupAdded = false
			clickInProgress = false

func _process(delta):
	if clickInProgress and withinTileBounds(mousePosition) and Input.is_mouse_button_pressed(BUTTON_LEFT) and isLongPress() and !popupAdded:
			var new_instance = ItemDescriptionPopup.instance()
			popupAdded = true
			new_instance.set_name("ItemDescriptionPopup")
			
			var item = getItem()
			if (item != null):
				new_instance.setItem(getItem())
			else:
				new_instance.setTitleAndDescription(getTitle(), getDescription())
				
			new_instance.setPopupPosition(mousePosition, popupPosition)
			popupContainer.add_child(new_instance)

func isLongPress():
	return (OS.get_ticks_msec() - pressStartTime) > longPressTime
	
func withinTileBounds(pos):
	var size = self.get_global_transform().get_scale() * self.get_size()
	
	return pos.x > self.get_global_position().x and pos.x < self.get_global_position().x + size.x and pos.y > self.get_global_position().y and pos.y < self.get_global_position().y + size.y
