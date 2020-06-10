extends Control

onready var alert = get_node("alert")

func _ready():
	InAppPurchases.set_auto_consume(false)
	InAppPurchases.connect("purchase_success", self, "on_purchase_success")
	InAppPurchases.connect("purchase_fail", self, "on_purchase_fail")
	InAppPurchases.connect("purchase_cancel", self, "on_purchase_cancel")
	InAppPurchases.connect("purchase_owned", self, "on_purchase_owned")
	InAppPurchases.connect("has_purchased", self, "on_has_purchased")
	InAppPurchases.connect("consume_success", self, "on_consume_success")
	InAppPurchases.connect("consume_fail", self, "on_consume_fail")
	InAppPurchases.connect("sku_details_complete", self, "on_sku_details_complete")

	get_node("purchase").connect("pressed", self, "button_purchase")
	get_node("consume").connect("pressed", self, "button_consume")
	get_node("request").connect("pressed", self, "button_request")
	get_node("query").connect("pressed", self, "button_query")


func on_purchase_success(item_name):
	alert.set_text("Purchase success : " + item_name)
	alert.popup()


func on_purchase_fail():
	alert.set_text("Purchase fail")
	alert.popup()


func on_purchase_cancel():
	alert.set_text("Purchase cancel")
	alert.popup()


func on_purchase_owned(item_name):
	alert.set_text("Purchase owned: " + item_name)
	alert.popup()


func on_has_purchased(item_name):
	if item_name == null:
		alert.set_text("Don't have purchased item")
	else:
		alert.set_text("Has purchased: " + item_name)
	alert.popup()


func on_consume_success(item_name):
	alert.set_text("Consume success: " + item_name)
	alert.popup()


func on_consume_fail():
	alert.set_text("Try to request purchased first")
	alert.popup()


func on_sku_details_complete():
	alert.set_text("Got detail info: " + to_json(InAppPurchases.sku_details["ad_free"]))
	alert.popup()


func button_purchase():
	InAppPurchases.purchase("ad_free")


func button_consume():
	InAppPurchases.consume("ad_free")


func button_request():
	InAppPurchases.request_purchased()


func button_query():
	InAppPurchases.sku_details_query(["ad_free", "android.test.purchased"])