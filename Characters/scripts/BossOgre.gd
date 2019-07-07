extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://Animations/HeavyImpact.tscn")
var AnimationsNode

func _ready():
	AnimationsNode = get_node("/root/Node2D/Animations")
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
		additionalRelativeAttackPositions = [Vector2(0, -1)]
	elif (turnBehaviour.Attacking()):
		addHeavyImpacts()
		
		changingBodyParts.get_node("Left Arm").set_flip_v( false )
		changingBodyParts.get_node("Right Arm").set_flip_v( false )
		
		additionalRelativeAttackPositions = []
		
		#animate attack
	elif (turnBehaviour.Recovering()):
		pass
		#animate stunned

func addHeavyImpacts():
	var attackPositions = absoluteAttackPositions(getNextTargetPos(original_pos / GameData.TileSize, turnBehaviour.attackDirection) * GameData.TileSize, turnBehaviour.attackDirection)
	
	for attackPosition in attackPositions:
		var heavyImpactInstance = HeavyImpact.instance()
		
		heavyImpactInstance.position = attackPosition
		AnimationsNode.add_child(heavyImpactInstance)

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()