extends TextureButton

func _process(delta):
	rect_position = GameData.player.get_node("Camera2D").get_camera_screen_center() - Vector2(540, 960)

func _pressed():
	if GameData.click_state:
		get_parent()._on_GameClickableRegion_clicked_inside(
			GameData.click_state
		)
