class SilverKey extends "KeyBase.gd":
	const texture = preload("res://assets/silver_key2.png")
	
	func _init():
		iconFilePath = "res://assets/silver_key2.png"
		description = "A Silver Key"
		item_name = "Silver Key"
		UnlockGuid = "Silver"
