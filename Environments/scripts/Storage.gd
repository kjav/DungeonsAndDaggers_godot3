extends "UnlockableBase.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

const SMALL_MAX_OFFSET = 50
const SMALL_MIN_OFFSET = 40
const MEDIUM_MAX_OFFSET = 35
const MEDIUM_MIN_OFFSET = 30
const LARGE_MAX_OFFSET = 10
const LARGE_MIN_OFFSET = 0

var Distribution = Constants.Distribution

var commonDrop = Distribution.new([
	{ "p": 0.9, "value": Constants.AllCommonItemsDistribution.pick()[0].value },
	{ "p": 0.1, "value": Constants.AllUncommonItemsDistribution.pick()[0].value }
])

var uncommonDrop = Distribution.new([
	{ "p": 0.45, "value": Constants.AllCommonPotionsSpellsDistribution.pick()[0].value },
	{ "p": 0.5, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
	{ "p": 0.05, "value": Constants.AllRarePotionsSpellsDistribution.pick()[0].value }
])

var rareDrop = Distribution.new([
	{ "p": 0.35, "value": Constants.AllCommonItemsDistribution.pick()[0].value },
	{ "p": 0.4, "value": Constants.AllUncommonItemsDistribution.pick()[0].value },
	{ "p": 0.25, "value": Constants.AllRareItemsDistribution.pick()[0].value }
])

var item_distribution = commonDrop

func _init():
	environment_name = "Common Storage"
	walkable = Enums.WALKABLE.NONE
	blocksAttacks = true

	setDistribution()

func setLocked(_locked):
	.setLockedButNotWalkable(_locked)

func keyUnlocked():
	.keyUnlocked()

func setDistribution():
	if GameData.current_level > GameData.bossLevelEvery:
		item_distribution = rareDrop
	elif GameData.current_level > GameData.bossLevelEvery / 2:
		item_distribution = uncommonDrop
	else:
		item_distribution = commonDrop


func remove():
	if(item_distribution != null):
		for item in item_distribution.pick():
			item.value.new().place(get_position())
	
	.remove()

func onWalkedInto(character):
	if !locked:
		GameData.player.clearMoveStack()
		startExplosions()
		get_node("StorageGraphics").get_node("large").get_node("explosion").connect("animation_finished",self,"remove", [], CONNECT_ONESHOT)

	if locked && character == GameData.player:
		var key = GameData.HasKey(UnlockGuid)
		
		if key != null:
			keyUnlocked()

func _ready():
	get_node("StorageGraphics").get_node("small").play(getAnimationName())
	get_node("StorageGraphics").get_node("medium").play(getAnimationName())
	get_node("StorageGraphics").get_node("large").play(getAnimationName())

	get_node("StorageGraphics").get_node("small").visible = getAdditionalStorageVisible()
	get_node("StorageGraphics").get_node("medium").visible = getAdditionalStorageVisible()
	
	get_node("StorageGraphics").get_node("small").position.x += getOffset(SMALL_MAX_OFFSET, SMALL_MIN_OFFSET)
	get_node("StorageGraphics").get_node("medium").position.x += getOffset(MEDIUM_MAX_OFFSET, MEDIUM_MIN_OFFSET)
	get_node("StorageGraphics").get_node("large").position.x += getOffset(LARGE_MAX_OFFSET, LARGE_MIN_OFFSET)
	
	._ready()

func setItemDistribution(dist):
	item_distribution = dist

func getAnimationName():
	if randi()%2 == 0:
		return "box"
	else:
		return "barrel"

func getAdditionalStorageVisible():
	return randi()%2 == 0

func getOffset(offsetMaxSize, offsetMinSizes):
	var value = randi()%int(offsetMaxSize - offsetMinSizes) + offsetMinSizes
	
	if randi()%2 == 0:
		value *=-1
	
	return value

func startExplosions():
	get_node("StorageGraphics").get_node("small").get_node("explosion").show()
	get_node("StorageGraphics").get_node("small").get_node("explosion").explode()
	get_node("StorageGraphics").get_node("medium").get_node("explosion").show()
	get_node("StorageGraphics").get_node("medium").get_node("explosion").explode()
	get_node("StorageGraphics").get_node("large").get_node("explosion").show()
	get_node("StorageGraphics").get_node("large").get_node("explosion").explode()
