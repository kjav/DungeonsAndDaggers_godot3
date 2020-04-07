extends Node2D

func _ready():
	Ad.connect("privacy_consent_obtained", self, "privacy_consent_obtained")

func hideMenu():
	get_tree().get_current_scene().get_node("HudNode").settingsOpen = false
	get_tree().paused = false
	self.queue_free()
	self.hide()

func privacy_consent_obtained():
	print("Privacy consent obtained")
	get_node("loading").hide()
