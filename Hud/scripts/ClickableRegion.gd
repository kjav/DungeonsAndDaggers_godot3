tool
extends Button

signal clicked_inside(event)
signal clicked_outside(event)

func _input(event):
	if event.is_action_pressed("click"):
		if self.get_rect().has_point(event.position):
			self.emit_signal("clicked_inside", event)
			get_node("../InventoryWrapperTop/TutorialArrow").hide()
		else:
			self.emit_signal("clicked_outside", event)
