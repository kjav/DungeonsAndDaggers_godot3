extends Node
var admob = null
var isReal = false

var adRewardId = "ca-app-pub-6580148569317237/9855207822"

func _ready():
	call_deferred("_init_ads")

func _init_ads():
	print("Engine has singleton: ", Engine.has_singleton("AdMob"))
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		var res = admob.init(isReal, get_instance_id())

		admob.resize()

func play_reward_video():
	print("Playing reward video: ", admob != null)
	if admob != null:
		admob.loadRewardedVideo(adRewardId)

func _on_rewarded_video_ad_left_application():
	pass

func _on_rewarded_video_ad_closed():
	pass

func _on_rewarded_video_ad_loaded():
	print("Showing video")
	admob.showRewardedVideo()

func _on_rewarded(currency, amount):
	print("Rewarded ", amount, " ", currency)