extends "EnvironmentBase.gd"
const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

const SMALL_MAX_OFFSET = 50
const SMALL_MIN_OFFSET = 49
const MEDIUM_MAX_OFFSET = 40
const MEDIUM_MIN_OFFSET = 39
const LARGE_MAX_OFFSET = 20
const LARGE_MIN_OFFSET = 19

var item_distribution

func _init():
	environment_name = 'Old Storage'
	walkable = Enums.WALKABLE.ALL
	blocksAttacks = true
	
	._init()

func remove():
	if(item_distribution != null):
		for item in item_distribution.pick():
			item.value.new().place(get_position())
	
	.remove()

func onWalkedInto(character):
	startExplosions()
	get_node("large").get_node("explosion").connect("animation_finished",self,"remove", [], CONNECT_ONESHOT)

func _ready():
	get_node("small").play(getAnimationName())
	get_node("medium").play(getAnimationName())
	get_node("large").play(getAnimationName())

	get_node("small").visible = getAdditionalStorageVisible()
	get_node("medium").visible = getAdditionalStorageVisible()
	
	get_node("small").position.x += getOffset(SMALL_MAX_OFFSET, SMALL_MIN_OFFSET)
	get_node("medium").position.x += getOffset(MEDIUM_MAX_OFFSET, MEDIUM_MIN_OFFSET)
	get_node("large").position.x += getOffset(LARGE_MAX_OFFSET, LARGE_MIN_OFFSET)
	
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
	get_node("small").get_node("explosion").show()
	get_node("small").get_node("explosion").explode()
	get_node("medium").get_node("explosion").show()
	get_node("medium").get_node("explosion").explode()
	get_node("large").get_node("explosion").show()
	get_node("large").get_node("explosion").explode()
