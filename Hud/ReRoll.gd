extends TextureButton

func _pressed():
	Ad.connect("reward_ad", get_parent(), "reroll")
	Ad.play_reward_video()