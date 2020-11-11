extends Node

signal purchase_success(item_name)
signal purchase_fail
signal purchase_cancel
signal purchase_owned(item_name)

signal has_purchased(item_name)

signal consume_success(item_name)
signal consume_fail
signal consume_not_required

signal sku_details_complete
signal sku_details_error

var payment
var to_purchase = []
var do_request_purchased = null

func _ready():
	pass
#	if Engine.has_singleton("GodotGooglePlayBilling"):
#		payment = Engine.get_singleton("GodotGooglePlayBilling")
#		payment.connect("connected", self, "_on_connected") # No params
#		payment.connect("disconnected", self, "_on_disconnected") # No params
#		payment.connect("connect_error", self, "_on_connect_error") # Response ID (int), Debug message (string)
#		payment.connect("purchases_updated", self, "_on_purchases_updated") # Purchases (Dictionary[])
#		payment.connect("purchase_error", self, "_on_purchase_error") # Response ID (int), Debug message (string)
#		payment.connect("sku_details_query_completed", self, "_on_sku_details_query_completed") # SKUs (Dictionary[])
#		payment.connect("sku_details_query_error", self, "_on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
#		payment.connect("purchase_acknowledged", self, "_on_purchase_acknowledged") # Purchase token (string)
#		payment.connect("purchase_acknowledgement_error", self, "_on_purchase_acknowledgement_error") # Response ID (int), Debug message (string), Purchase token (string)
#		payment.connect("purchase_consumed", self, "_on_purchase_consumed") # Purchase token (string)
#		payment.connect("purchase_consumption_error", self, "_on_purchase_consumption_error") # Response ID (int), Debug message (string), Purchase token (string)
#	else:
#		print("GodotGooglePlayBilling singleton is only available on Android devices.")


#	InAppPurchases.connect("purchase_success", self, "on_purchase_success")
#	InAppPurchases.connect("has_purchased", self, "on_has_purchased")
#	InAppPurchases.connect("purchase_owned", self, "purchase_owned")

func _on_connect_error(ints, strings):
	pass
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print("_on_connect_error")
#	print(strings)
#	print(ints)

func _on_purchase_error(ints, strings):
	pass
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print("_on_purchase_error")
#	print(strings)
#	print(ints)

func _on_purchase_acknowledgement_error(ints, strings, strings2):
	pass
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print("purchase_acknowledgement_error")
#	print(ints)
#	print(strings)
#	print(strings2)

func _on_purchase_acknowledged(strings):
	pass
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print("purchase_acknowledged")
#	print(strings)

func _on_connected():
	pass
#	print("on_connected")
#	print("on_connected")
#	print("on_connected")
#	print("on_connected")
#	print("on_connected")
#	print("on_connected")
#	print("on_connected")
#	print(Constants.AppStoreMicrotransactions.AdFree)
#	payment.querySkuDetails([Constants.AppStoreMicrotransactions.AdFree], "inapp") # "subs" for subscriptions
#	print("on_connected")

func _on_sku_details_query_completed(sku_details):
	pass
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	print("_on_sku_details_query_completed")
#	for item_name in to_purchase:
#		print("payment.purchase")
#		print(item_name)
#		payment.purchase(item_name)
#	if do_request_purchased:
#		_request_purchased()
#		do_request_purchased = null

func _on_sku_details_query_error(id, msg, skus):
	pass
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)
#	print("$#$#$# ERROR: ", id, ", ", msg)

func purchase(item_name):
	pass
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print("purcchasing")
#	print(item_name)
#	if payment:
#		print("payment.purchase(item_name) - if purchase")
#		payment.purchase(item_name)
#		print("payment.purchase(item_name) - if purchase - completed")
#	else:
#		to_purchase.push_back(item_name)

func request_purchased():
	pass
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	print("request_purchased")
#	if payment:
#		_request_purchased()
#	else:
#		do_request_purchased = true

func _request_purchased():
	pass
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	print("_request_purchased")
#	var query = payment.queryPurchases("inapp") # Or "subs" for subscriptions
#	if query.status == OK:
#		for purchase in query.purchases:
#			if !purchase.is_acknowledged:
#				payment.acknowledgePurchase(purchase.purchase_token)
#			emit_signal("has_purchased", purchase.sku)

func _on_purchases_updated(purchases):
	pass
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	print("_on_purchases_updated")
#	for key in purchases.keys():
#		emit_signal("purchase_success", key)
