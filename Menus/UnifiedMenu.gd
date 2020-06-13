extends Node2D

export(Curve) var transition_curve
export(float) var transition_time = 1.0

var transitioning = false
var target_pos
var current_time
var printed = false

func _ready():
	match GameData.start_screen:
		"world_select":
			position = Vector2(-1180, 0)
		_: # The default
			position = Vector2(0, 0)
	Ad.connect("privacy_consent_obtained", self, "privacy_consent_obtained")
	
	InAppPurchases.set_auto_consume(false)
	InAppPurchases.consume("ad_free")
	InAppPurchases.connect("purchase_success", self, "on_purchase_success")
	InAppPurchases.connect("has_purchased", self, "on_has_purchased")
	InAppPurchases.connect("purchase_owned", self, "purchase_owned")
	InAppPurchases.request_purchased()

func on_has_purchased(item_name):
	applyMicrotransaction(item_name)

func on_purchase_success(item_name):
	applyMicrotransaction(item_name)

func purchase_owned(sku):
	OS.alert("Purchase Already Owned")

func applyMicrotransaction(item_name):
	if not item_name == null:
		if item_name == Constants.AppStoreMicrotransactions.AdFree:
			GameData.adFree = true;

func privacy_consent_obtained():
	print("Privacy consent obtained")
	get_node("loading").hide()

func _process(delta):
	if transitioning:
		current_time += delta
		if current_time > transition_time:
			transitioning = false
			#get_node("PlayerSelect/Node2D").transitioning = false
			position = target_pos
		else:
			var ratio = transition_curve.interpolate_baked(current_time / transition_time)
			position = target_pos * ratio

func _on_splashbutton_start():	
	if not transitioning:
		target_pos = -Vector2(1180, 0)
		current_time = 0.0
		transitioning = true
		#get_node("PlayerSelect/Node2D").transitioning = true

func _on_worldbutton_pressed():
	if not transitioning:
		GameData.StartNewGame()

func reroll(a, b):
	print("Reroll!")
