extends TextureButton

func _ready():
	if GameData.adFree:
		get_node("Label").text = "Click To\n\rRevive"
	
	Ad.connect("reward_ad", self, "revive")
	Ad.connect("cancel_ad", self, "cancel")

func revive(currency, amount):
	if currency == "revive":
		GameAnalytics.queue_design_event('RewardAd:revive')
		get_node("loading").hide()
		get_node("skull").show()
		GameData.player.revive()
		disabled = true
		get_node("skull").material.set_shader_param("grayscale", true)
		get_parent().get_parent().hide()
		get_parent().get_parent().get_node("AnimationPlayer").play_backwards("death screen fade in")

func reset():
	get_node("skull").material.set_shader_param("grayscale", false)
	get_node("Label").self_modulate = Color('fff500')

func _pressed():
	get_node("loading").show()
	get_node("skull").hide()
	Ad.play_reward_video("revive")
	get_node("Label").self_modulate = Color('4d4d4d')

func cancel(currency):
	if currency == "revive":
		get_node("loading").hide()
		get_node("skull").show()
		reset()
