extends TextureButton

func pressed():
	Ad.connect("reward_ad", get_parent(), "reroll")
	Ad.play_reward_video()
