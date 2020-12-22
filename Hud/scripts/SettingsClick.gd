extends TextureButton
const Scene = preload("res://Hud/Settings.tscn")

func _pressed():
	if not get_tree().get_current_scene().get_node("HudNode").settingsOpen:
		var new_instance = Scene.instance()
		new_instance.set_name("Settings")
		get_tree().get_current_scene().get_node("HudNode").get_node("HudCanvasLayer").add_child(new_instance)
		get_tree().get_current_scene().get_node("HudNode").settingsOpen = true
		GameData.player.get_node("Camera2D").zoom = Vector2(3,3)
		get_tree().paused = true
