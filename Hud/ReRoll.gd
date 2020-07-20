extends TextureButton

func _ready():
	if GameData.adFree or GameData.chosen_map == "Tutorial":
		get_node("Label").text = "Re-Roll"
		
	Ad.connect("reward_ad", get_parent(), "reroll")
	Ad.connect("cancel_ad", self, "cancel")

func _pressed():
	get_node("Loading").show()
	get_node("Trophy").hide()
	Ad.play_reward_video("reroll")
	get_node("Label").self_modulate = Color('4d4d4d')

func cancel(currency):
	if currency == "reroll":
		GameAnalytics.queue_design_event('RewardAd:reroll')
		get_node("Loading").hide()
		get_node("Trophy").show()
