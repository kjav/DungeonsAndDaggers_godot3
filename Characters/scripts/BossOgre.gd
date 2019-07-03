extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")

func _ready():
	turnBehaviour = Turn.MoveToWaitBeforeAndAfterAttackTwoInFront.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Boss Ogre'
	base_damage = 3
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.CookedSteak}])
	
	initialStats.health = {
		"value": 12,
		"maximum": 12
	}
	
	._ready()

func turn():
	.turn()
	
	var changingBodyParts = get_node("ChangingBodyParts")
	
	if (turnBehaviour.PreparingAttack()):
		changingBodyParts.get_node("Left Arm").set_flip_v( true )
		changingBodyParts.get_node("Right Arm").set_flip_v( true )
	elif (turnBehaviour.Attacking()):
		changingBodyParts.get_node("Left Arm").set_flip_v( false )
		changingBodyParts.get_node("Right Arm").set_flip_v( false )
		
		#animate attack
	elif (turnBehaviour.Recovering()):
		pass
		#animate stunned

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()