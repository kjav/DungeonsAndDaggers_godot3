extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
var turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new()
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
var processBehaviour = Process.StraightTransition.new()

func _ready():
	self.character_name = 'Baby Ogre'
	base_damage = 3
	turnBehaviour.setWaitEvery(3)
	turnBehaviour.setLimit(100)
	turnBehaviour.init()
	item_distribution = Constants.IndependentDistribution.new([{"p": 0.5, "value": Constants.FoodClasses.CookedSteak}])

func turn():
	moving = moveDirection(turnBehaviour.getDirection(original_pos))

func _process(delta):
	var state = processBehaviour.getNewState(get_position(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_position(state[0])
	if (self.moving && !state[1]):
		original_pos = get_position()
	if state[1] != null:
		self.moving = state[1]
