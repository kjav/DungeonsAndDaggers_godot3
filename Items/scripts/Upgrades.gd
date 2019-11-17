class StrengthUpgrade3 extends "Upgrade.gd":
	func _init():
		texture = preload("res://assets/37_a.png")
		description="Increases your strength level, making you hit more consistently.\n\n   +3 strength"
		title="Berserker"
	
	func onUse():
		GameData.player.increaseStat("strength", 3)

class DefenceUpgrade3 extends "Upgrade.gd":
	func _init():
		texture = preload("res://assets/33_a.png")
		description="Increases your defence level, making enemies less likely to hit you.\n\n   +3 defence"
		title="Thick Skin"
	
	func onUse():
		GameData.player.increaseStat("defence", 3)

class HealthUpgrade1 extends "Upgrade.gd":
	func _init():
		texture = preload("res://assets/28_a.png")
		description="Increases your total hitpoints, so you will last longer in battle.n\n   +1 Hitpoints"
		title="Constitution"
	
	func onUse():
		GameData.player.increaseMaxHealth(1)
		GameData.player.heal(1)
