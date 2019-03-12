extends Node

func hideMenu(event):
	get_tree().get_current_scene().get_node("HudNode").settingsOpen = false
	self.queue_free()
	self.hide()
