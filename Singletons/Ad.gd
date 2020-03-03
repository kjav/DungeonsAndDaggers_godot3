extends Node
var admob = null
var isReal = false

var adRewardId = "ca-app-pub-6580148569317237/9855207822"

func _ready():
	call_deferred("_init_ads")

func _init_ads():
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		var res = admob.init(isReal, get_instance_id())

		#admob.connect("_on_rewarded", self, "on_rewarded")
		#admob.resize()

func play_reward_video():
	if admob:
		admob.loadRewardedVideo(adRewardId)
		admob.showRewardedVideo()

func on_rewarded(currency, amount):
	print("Rewarded ", amount, " ", currency)