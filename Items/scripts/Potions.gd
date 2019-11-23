class HealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_potion2.png"
		item_name = "Health"
		useSound = "HealthPotion_Drink"
		texture = preload("res://assets/red_potion2.png")
		rarity = Enums.WEAPONRARITY.UNCOMMON
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.increaseMaxHealth(1)

class DoubleDamagePotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_potion.png"
		item_name = "Double Damage"
		texture = preload("res://assets/black_potion.png")
		rarity = Enums.WEAPONRARITY.RARE
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyDamageModifier(3)

class InvisibilityPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/clear_potion.png"
		item_name = "Invisibility"
		texture = preload("res://assets/clear_potion.png")
		rarity = Enums.WEAPONRARITY.UNCOMMON
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyInvisibility(10)

class LevelUpPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/special_potion.png"
		item_name = "Level Up"
		texture = preload("res://assets/special_potion.png")
		rarity = Enums.WEAPONRARITY.RARE
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.hud.show_upgrade_menu()

class BreifHealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_simple_potion.png"
		item_name = "Breif Health"
		texture = preload("res://assets/red_simple_potion.png")
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyTemporaryHealth(15)
		
class BreifManaPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/blue_simple_potion.png"
		item_name = "Breif Mana"
		texture = preload("res://assets/blue_simple_potion.png")
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyTemporaryMana(15)

class BreifStrengthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/green_simple_potion.png"
		item_name = "Breif Strength"
		texture = preload("res://assets/green_simple_potion.png")
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyTemporaryStrength(15)
		
class BreifDefencePotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_simple_potion.png"
		item_name = "Breif Defence"
		texture = preload("res://assets/black_simple_potion.png")
	
	func onUse():
		if not .allowedToUse():
			.eventMessageForTurnUse()
			return
		
		.onUse()
		GameData.player.applyTemporaryDefence(15)
