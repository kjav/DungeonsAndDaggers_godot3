extends "Item.gd"

func init():
	useSound = "Food_Use"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addFoods([self])
	.pickup()

func onUse():
	.onUse()
	GameData.foods.remove(GameData.foods.find(self))
	#Audio.playSoundEffect(useSound, true)