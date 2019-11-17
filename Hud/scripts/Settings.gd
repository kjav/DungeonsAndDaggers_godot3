extends Node2D

func hideMenu(event):
	get_tree().get_current_scene().get_node("HudNode").settingsOpen = false
	get_tree().paused = false
	self.queue_free()
	self.hide()
