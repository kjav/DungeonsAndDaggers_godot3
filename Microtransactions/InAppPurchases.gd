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

func _ready():
	if Engine.has_singleton("GodotPayments"):
		payment = Engine.get_singleton("GodotPayments")
		
		self.connect("consume_success", self, "on_consume_success")
	else:
		print("GodotPayment singleton is only available on Android devices.")

	if payment:
		# Set callback with this script instance.
		payment.setPurchaseCallbackId(get_instance_id())

# Set consume purchased item automatically after purchase, default value is true.
func set_auto_consume(auto):
	if payment:
		payment.setAutoConsume(auto)


# Request user owned item, callback: has_purchased.
func request_purchased():
	if payment:
		payment.requestPurchased()

func has_purchased(_receipt, _signature, sku):
	if sku == "":
		emit_signal("has_purchased", null)
	else:
		emit_signal("has_purchased", sku)

func on_consume_success(item):
	pass

# purchase item
# callback : purchase_success, purchase_fail, purchase_cancel, purchase_owned
func purchase(item_name):
	if payment:
		# transaction_id could be any string that used for validation internally in java
		payment.purchase(item_name, "transaction_id")


func purchase_success(_receipt, _signature, sku):
	emit_signal("purchase_success", sku)


func purchase_fail():
	emit_signal("purchase_fail")


func purchase_cancel():
	emit_signal("purchase_cancel")


func purchase_owned(sku):
	emit_signal("purchase_owned", sku)


# Consume purchased item.
# Callback: consume_success, consume_fail
func consume(item_name):
	if payment:
		payment.consume(item_name)


# Consume all purchased items.
func consume_all():
	if payment:
		payment.consumeUnconsumedPurchases()


func consume_success(_receipt, _signature, sku):
	print("consume_success : ", sku)
	emit_signal("consume_success", sku)


# If consume fails, need to call request_purchased() to get purchase token from Google.
# Then try to consume again.
func consume_fail():
	emit_signal("consume_fail")


# No purchased item to consume.
func consume_not_required():
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
	if payment:
		var sku_list = PoolStringArray(list)
		payment.querySkuDetails(sku_list)

func sku_details_complete(result):
	for key in result.keys():
		sku_details[key] = result[key]
	emit_signal("sku_details_complete")


func sku_details_error(error_message):
	emit_signal("sku_details_error")
