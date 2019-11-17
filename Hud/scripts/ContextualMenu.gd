extends Node2D

func activate(pos):
	var items = GameData.itemsAtPos(pos)
	var stairs = GameData.stairsAtPos(pos)
	
	populateItems(items)
	populateLevelOption(stairs)

func populateLevelOption(stairs):
	if stairs != null:
		get_node("LevelSelect").show()
		get_node("LevelSelectText").show()
		#update text to right level / boss
	else:
		get_node("LevelSelect").hide()
		get_node("LevelSelectText").hide()

func populateItems(items):
	for itemNumber in range(1, 9):
		var itemNode = get_node("ItemNode" + str(itemNumber))
		
		if itemNumber <= items.size():
			itemNode.show()
			itemNode.get_node("icon").texture = items[itemNumber-1].texture
			itemNode.get_node("frame").item = items[itemNumber-1]
		else:
			itemNode.hide()