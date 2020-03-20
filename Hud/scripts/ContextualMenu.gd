extends Node2D

var lastPos
var weaponBase = preload("res://Items/scripts/weapons/WeaponBase.gd")

func _ready():
	get_node("ItemNode1").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode2").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode3").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode4").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode5").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode6").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode7").get_node("frame").connect("pressed",self,"refresh") 
	get_node("ItemNode8").get_node("frame").connect("pressed",self,"refresh") 

func activate(pos):
	lastPos = pos
	
	var items = GameData.itemsAtPos(pos)
	var stairs = GameData.stairsAtPos(pos)
	
	populateItems(items)
	populateLevelOption(stairs)
	
func refresh():
	activate(lastPos)

func populateLevelOption(stairs):
	if stairs != null:
		get_node("LevelSelect").show()
		get_node("LevelSelectText").show()
		
		var nextLevel = GameData.current_level + 1
		var levelText
		
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 2:
			levelText = "Main game"
		elif GameData.isBossLevel(nextLevel):
			levelText = "Boss level"
		else:
			levelText = "Level " + str(nextLevel)
		
		get_node("LevelSelectText").text = levelText
	else:
		get_node("LevelSelect").hide()
		get_node("LevelSelectText").hide()

func populateItems(items):
	for itemNumber in range(1, 9):
		var itemNode = get_node("ItemNode" + str(itemNumber))
		
		if itemNumber <= items.size():
			itemNode.show()
			itemNode.get_node("icon").texture = getItemTexture(items[itemNumber-1])
			itemNode.get_node("frame").item = items[itemNumber-1]
			itemNode.get_node("background").texture = GameData.getBackgroundForRarity(items[itemNumber-1].rarity)
		else:
			itemNode.hide()

func getItemTexture(item):
	var texture = item.texture

	if "iconTexture" in item:
		texture = item.iconTexture

	return texture