extends TextureButton

const ItemDescriptionPopup = preload("res://Hud/ItemDescriptionPopup.tscn")
var popupAdded = true
var pressStartTime = OS.get_ticks_msec()
var mousePosition

func _input(event):
	if event.is_action_pressed("click"):
		pressStartTime = OS.get_ticks_msec()
		popupAdded = false
		mousePosition = event.position
	elif event.is_action_released("click"):
		if popupAdded:
			get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").get_node("ItemDescriptionPopup").hidePopup()
		elif !isLongPress():
				var parent = self.get_parent()
				
				parent.queue_free()
				parent.hide()
				parent.get_parent().selectItem(parent)
				parent.instance.onUse()
func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and isLongPress() and !popupAdded:
			var new_instance = ItemDescriptionPopup.instance()
			popupAdded = true
			new_instance.set_name("ItemDescriptionPopup")
			get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").add_child(new_instance)
			new_instance.setPopupPosition(mousePosition)

func isLongPress():
	return (OS.get_ticks_msec() - pressStartTime) > 100