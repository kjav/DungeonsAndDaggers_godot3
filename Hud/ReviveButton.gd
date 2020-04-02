extends TextureButton

func _ready():
	Ad.connect("reward_ad", self, "revive")
	Ad.connect("cancel_ad", self, "cancel")

func revive(currency, amount):
	if currency == "revive":
		get_node("loading").hide()
		get_node("skull").show()
		GameData.player.revive()
		disabled = true
		get_node("skull").material.set_shader_param("grayscale", true)
		get_parent().hide()

func _pressed():
	get_node("loading").show()
	get_node("skull").hide()
	Ad.play_reward_video("revive")

func cancel(currency):
	if currency == "revive":
		get_node("loading").hide()
		get_node("skull").show()
