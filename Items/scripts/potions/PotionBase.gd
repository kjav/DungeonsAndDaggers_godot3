extends "../Item.gd"

func _init():
	._init()
	typeNameForMessage = " Potion"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addPotions([self])
	.pickup()

func onWalkedOut():
	pass

func onUse():
	GameData.potions.remove(GameData.potions.find(self))
	.onUse()
	
	if !GameData.player.firstPotionTurnFree || !GameData.player.isFirstPotion:
		GameData.player.forceTurnEnd()
	
	GameData.player.isFirstPotion = false
