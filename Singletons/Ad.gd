extends Node
var admob = null
var consent = null
var isReal
var childDirected = false
var personalised = false
var rating = "T"
var ready_to_load = false
var personalised_checked = false

var loaded = false
var do_play = false
var currency = ""

var rewardAdId = "ca-app-pub-6580148569317237/9855207822"

signal reward_ad(currency, amount)
signal cancel_ad(currency)
signal privacy_consent_obtained

func _init():
	isReal = !GameData.TESTING

func _ready():
	ready_to_load = true
	
	if Engine.has_singleton("MySingleton"):
		consent = Engine.get_singleton("MySingleton")
		call_deferred("_init_consent")
	
	if ready_to_load and personalised_checked:
		call_deferred("_init_ads")

func getDeviceVersion():
	return consent.getDeviceVersion()

func show_privacy_form():
	if consent == null:
		emit_signal("privacy_consent_obtained")
	else:
		consent.showConsentForm()

func _init_consent():
	consent.init(get_instance_id())

func _on_consent_fail(e):
	print("Failed to obtain consent: ")
	print(e)

func _on_consent_success():
	print("Consent success")

func _on_consent_unknown():
	print("Consent unknown")
	consent.showConsentForm()

func _on_consent_forward(acceptedPersonalised, requestedAdFree):
	print("Consent forwarded: ", acceptedPersonalised)
	
	if !requestedAdFree:
		personalised = acceptedPersonalised
	
	personalised_checked = true
	emit_signal("privacy_consent_obtained")
	
	if ready_to_load and personalised_checked:
		call_deferred("_init_ads")
		GameAnalytics.start_analytics()
		
	if requestedAdFree:
		print("consent purchase")
		print(Constants.AppStoreMicrotransactions.AdFree)
		InAppPurchases.purchase(Constants.AppStoreMicrotransactions.AdFree)

func _on_consent_loaded():
	print("Consent loaded")

func _on_consent_opened():
	print("Consent opened")

func _on_consent_error(e):
	print("Consent error: ", e)
	emit_signal("privacy_consent_obtained")

func _init_ads():
	if(Engine.has_singleton("AdMob") && !GameData.adFree):
		admob = Engine.get_singleton("AdMob")
		var res = admob.initWithContentRating(
			isReal,
			get_instance_id(),
			childDirected,
			personalised,
			rating
		)

		admob.resize()
		admob.loadRewardedVideo(rewardAdId)

func play_reward_video(name):
	currency = name
	
	if !GameData.adFree and GameData.chosen_map != "Tutorial":
		if admob == null:
			emit_signal("reward_ad", currency, 1)
		else:
			do_play = true
			if loaded:
				loaded = false
				do_play = false
				admob.showRewardedVideo()
				admob.loadRewardedVideo(rewardAdId)
	else:
		_on_rewarded(null, 1)

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
	if !GameData.adFree and GameData.chosen_map != "Tutorial":
		admob.loadRewardedVideo(rewardAdId)
	emit_signal("reward_ad", currency, amount)
