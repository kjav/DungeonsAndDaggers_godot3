extends "Item.gd"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addFoods([self])
	.pickup()