extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

const SMALL_MAX_OFFSET = 130
const SMALL_MIN_OFFSET = 110
const MEDIUM_MAX_OFFSET = 120
const MEDIUM_MIN_OFFSET = 100
const LARGE_MAX_OFFSET = 50
const LARGE_MIN_OFFSET = 0

func _init():
	self.character_name = 'Old Storage'
	
	hasOnlyRightAnimations = true
	walkAnimationUsesStand = true
	
func _ready():
	get_node("small").play(getAnimationName())
	get_node("medium").play(getAnimationName())
	get_node("large").play(getAnimationName())

	get_node("small").visible = getAdditionalStorageVisible()
	get_node("medium").visible = getAdditionalStorageVisible()
	
	get_node("small").position.x += getOffset(SMALL_MAX_OFFSET, SMALL_MIN_OFFSET)
	get_node("medium").position.x += getOffset(MEDIUM_MAX_OFFSET, MEDIUM_MIN_OFFSET)
	get_node("large").position.x += getOffset(LARGE_MAX_OFFSET, LARGE_MIN_OFFSET)
	
	turnBehaviour = Turn.Wait.new(self)
	processBehaviour = Process.Direct.new()
	fixedMaxHealth = true
	
	setBaseDamage(0, 0)
	setInitialHealth(1, 1, 0)
	setInitialStats(1, 1, 1, 1, 0)
	
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
