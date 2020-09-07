extends "../Item.gd"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addFoods([self])
	.pickup()

func onWalkedOut():
	pass

func onUse():
	.onUse()
	GameData.foods.remove(GameData.foods.find(self))

	if !GameData.player.firstFoodTurnFree || !GameData.player.isFirstFood:
		GameData.player.forceTurnEnd()

	GameData.player.isFirstFood = false
