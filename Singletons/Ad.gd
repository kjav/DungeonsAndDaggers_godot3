extends Node
var admob = null
var isReal = false

var loaded = false
var do_play = false
var currency = ""

var rewardAdId = "ca-app-pub-6580148569317237/9855207822"

signal reward_ad(currency, amount)
signal cancel_ad(currency)

func _ready():
	call_deferred("_init_ads")

func _init_ads():
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		var res = admob.init(isReal, get_instance_id())

		admob.resize()
		admob.loadRewardedVideo(rewardAdId)

func play_reward_video(name):
	currency = name
	if admob == null:
		emit_signal("reward_ad", currency, 1)
	else:
		do_play = true
		if loaded:
			loaded = false
			do_play = false
			admob.showRewardedVideo()
			admob.loadRewardedVideo(rewardAdId)

func _on_rewarded_video_ad_left_application():
	admob.loadRewardedVideo(rewardAdId)
	emit_signal("cancel_ad", currency)

func _on_rewarded_video_ad_closed():
	admob.loadRewardedVideo(rewardAdId)
	emit_signal("cancel_ad", currency)

func _on_rewarded_video_ad_loaded():
	loaded = true
	if do_play:
		do_play = false
		loaded = false
		admob.showRewardedVideo()

func _on_rewarded(unused, amount):
	admob.loadRewardedVideo(rewardAdId)
	emit_signal("reward_ad", currency, amount)
