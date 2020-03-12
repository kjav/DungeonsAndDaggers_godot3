extends TextureButton

func _ready():
	Ad.connect("reward_ad", get_parent(), "reroll")

func _pressed():
	Ad.play_reward_video()
	get_node("Loading").show()
	get_node("Trophy").hide()