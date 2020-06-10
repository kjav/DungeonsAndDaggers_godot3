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

func aaaa(a):
	pass#GameData.test.get_node("Label").text += a

func _ready():
	if Engine.has_singleton("GodotPayments"):
		payment = Engine.get_singleton("GodotPayments")
		
		self.connect("consume_success", self, "on_consume_success")
		
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		timer.connect("timeout",self,"aaaa",["GodotPayment available"]) 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()
	else:
		print("GodotPayment singleton is only available on Android devices.")
		
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		timer.connect("timeout",self,"aaaa",["GodotPayment unavailable"]) 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()

	if payment:
		# Set callback with this script instance.
		
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		timer.connect("timeout",self,"aaaa",["GodotPayment payment"]) 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()
		payment.setPurchaseCallbackId(get_instance_id())
	else:
		
		var timer = Timer.new()
		timer.set_wait_time(0.1)
		timer.connect("timeout",self,"aaaa",["GodotPayment no payment"]) 
		timer.set_one_shot(true)
		add_child(timer)
		timer.start()

# Set consume purchased item automatically after purchase, default value is true.
func set_auto_consume(auto):
#	GameData.test.get_node("Label").text += "set_auto_consume " + payment
	if payment:
		payment.setAutoConsume(auto)


# Request user owned item, callback: has_purchased.
func request_purchased():
#	GameData.test.get_node("Label").text += "request purchased " + payment
	if payment:
		payment.requestPurchased()

func has_purchased(_receipt, _signature, sku):
	if sku == "":
		#GameData.test.get_node("Label").text += "has_purchased : nothing"
		emit_signal("has_purchased", null)
	else:
		
		#GameData.test.get_node("Label").text += "has_purchased : " + sku
		emit_signal("has_purchased", sku)

func on_consume_success(item):
	pass
	#GameData.test.get_node("Label").text += " uhoh something consumed " + str(item)

# purchase item
# callback : purchase_success, purchase_fail, purchase_cancel, purchase_owned
func purchase(item_name):
	
	#GameData.test.get_node("Label").text += "purchase " + payment
	if payment:
		# transaction_id could be any string that used for validation internally in java
		payment.purchase(item_name, "transaction_id")


func purchase_success(_receipt, _signature, sku):
	
	#GameData.test.get_node("Label").text += "purchase_success : " + sku
	emit_signal("purchase_success", sku)


func purchase_fail():
	
	#GameData.test.get_node("Label").text += "purchase_fail"
	emit_signal("purchase_fail")


func purchase_cancel():
	
	#GameData.test.get_node("Label").text += "purchase_cancel"
	emit_signal("purchase_cancel")


func purchase_owned(sku):
	
	#GameData.test.get_node("Label").text += "purchase_owned : " + sku
	emit_signal("purchase_owned", sku)


# Consume purchased item.
# Callback: consume_success, consume_fail
func consume(item_name):
	
	#GameData.test.get_node("Label").text += "consume " + payment
	if payment:
		payment.consume(item_name)


# Consume all purchased items.
func consume_all():
	
	#GameData.test.get_node("Label").text += "consume_all " + payment
	if payment:
		payment.consumeUnconsumedPurchases()


func consume_success(_receipt, _signature, sku):
	#GameData.test.get_node("Label").text += "consume_sucess " + sku
	print("consume_success : ", sku)
	emit_signal("consume_success", sku)


# If consume fails, need to call request_purchased() to get purchase token from Google.
# Then try to consume again.
func consume_fail():
	#GameData.test.get_node("Label").text += "consume_fail "
	emit_signal("consume_fail")


# No purchased item to consume.
func consume_not_required():
	#GameData.test.get_node("Label").text += "consume_not_required"
	emit_signal("consume_not_required")


# Detail info of IAP items:
# sku_details = {
#     product_id (String) : {
#         type (String),
#         product_id (String),
#         title (String),
#         description (String),
#         price (String),  # this can be used to display price for each country with their own currency
#         price_currency_code (String),
#         price_amount (float)
#     },
#     ...
# }
var sku_details = {}

# Query for details of IAP items.
# Callback: sku_details_complete
func sku_details_query(list):
	#GameData.test.get_node("Label").text += "sku_details_query " + payment + " a " + list 
	if payment:
		var sku_list = PoolStringArray(list)
		payment.querySkuDetails(sku_list)

func sku_details_complete(result):
	#GameData.test.get_node("Label").text += "sku_details_complete : " + result
	for key in result.keys():
		sku_details[key] = result[key]
	emit_signal("sku_details_complete")


func sku_details_error(error_message):
	
	#GameData.test.get_node("Label").text += "error_sku_details = " + error_message
	emit_signal("sku_details_error")
