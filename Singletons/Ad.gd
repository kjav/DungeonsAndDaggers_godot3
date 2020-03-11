extends Node
var admob = null
var isReal = false
var do_play_reward_video = false
var reward_video_loaded = false

var adRewardId = "ca-app-pub-6580148569317237/9855207822"

signal reward_ad(currency, amount)

func _ready():
	call_deferred("_init_ads")

func _init_ads():
	if(Engine.has_singleton("AdMob")):
		admob = Engine.get_singleton("AdMob")
		var res = admob.init(isReal, get_instance_id())

		admob.resize()
		admob.loadRewardedVideo(adRewardId)

func play_reward_video():
	if admob == null:
		emit_signal("reward_ad", "", 0)
	else:
		do_play_reward_video = true
		
		if reward_video_loaded:
			reward_video_loaded = false
			do_play_reward_video = false
			admob.showRewardedVideo()
			admob.loadRewardedVideo(adRewardId)

func _on_rewarded_video_ad_left_application():
	admob.loadRewardedVideo(adRewardId)

func _on_rewarded_video_ad_closed():
	admob.loadRewardedVideo(adRewardId)

func _on_rewarded_video_ad_loaded():
	reward_video_loaded = true
	if do_play_reward_video:
		do_play_reward_video = false
		reward_video_loaded = false
		admob.showRewardedVideo()

func _on_rewarded(currency, amount):
	admob.loadRewardedVideo(adRewardId)
	emit_signal("reward_ad", currency, amount)