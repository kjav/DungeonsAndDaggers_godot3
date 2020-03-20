extends TextureButton

func _ready():
	Ad.connect("reward_ad", get_parent(), "reroll")

func _pressed():
	get_node("Loading").show()
	get_node("Trophy").hide()
	Ad.play_reward_video("reroll")