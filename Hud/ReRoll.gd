extends TextureButton

func _ready():
	Ad.connect("reward_ad", get_parent(), "reroll")
	Ad.connect("cancel_ad", self, "cancel")

func _pressed():
	get_node("Loading").show()
	get_node("Trophy").hide()
	Ad.play_reward_video("reroll")

func cancel(currency):
	if currency == "reroll":
		get_node("Loading").hide()
		get_node("Trophy").show()