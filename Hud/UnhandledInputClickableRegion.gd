tool
extends Button

signal clicked_inside(event)
signal clicked_outside(event)

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		if self.get_rect().has_point(event.position):
			self.emit_signal("clicked_inside", event)
		else:
			self.emit_signal("clicked_outside", event)
