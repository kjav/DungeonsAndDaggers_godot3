tool
extends Button

signal clicked_inside(event)
signal clicked_outside(event)

export(int, "Input", "Unhandled Input") var triggerOn  = 0 setget setTriggerOn, getTriggerOn

func setTriggerOn(value):
	if typeof(value) == TYPE_INT:
		triggerOn = value
		if triggerOn == 0:
			set_process_input(true)
			set_process_unhandled_input(false)
		else:
			set_process_input(false)
			set_process_unhandled_input(true)

func getTriggerOn():
	return triggerOn

func _ready():
	if triggerOn == 0:
		set_process_input(true)
		set_process_unhandled_input(false)
	else:
		set_process_input(false)
		set_process_unhandled_input(true)

func _input(event):
	if event.is_action_pressed("click"):
		if self.get_rect().has_point(event.position):
			self.emit_signal("clicked_inside", event)
		else:
			self.emit_signal("clicked_outside", event)

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		if self.get_rect().has_point(event.position):
			self.emit_signal("clicked_inside", event)
		else:
			self.emit_signal("clicked_outside", event)
