extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
var EffectsNode

func _ready():
	EffectsNode = get_node("/root/Node2D/Effects")
	turnBehaviour = Turn.MoveToWaitBeforeAttackRecoverIfMissed.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Boss Ogre'
	base_damage = 3
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.CookedSteak}])
	self.get_node("Stars").hide()
	
	initialStats.health = {
		"value": 12,
		"maximum": 12
	}
	
	._ready()

func turn():
	.turn()
	
	var changingBodyParts = get_node("ChangingBodyParts")
	
	if (!turnBehaviour.Recovering()):
		self.get_node("Stars").hide()
	else:
		self.get_node("Stars").show()
	
	if (turnBehaviour.PreparingAttack()):
		changingBodyParts.get_node("Left Arm").set_flip_v( true )
		changingBodyParts.get_node("Right Arm").set_flip_v( true )
		additionalRelativeAttackPositions = [Vector2(0, -1)]
		turnBehaviour.additionalRelativeAttackPositions = [Vector2(0, -1)]
	elif (turnBehaviour.Attacking()):
		addHeavyImpacts()
		
		changingBodyParts.get_node("Left Arm").set_flip_v( false )
		changingBodyParts.get_node("Right Arm").set_flip_v( false )
		
		turnBehaviour.additionalRelativeAttackPositions = []
		additionalRelativeAttackPositions = []

func addHeavyImpacts():
	var attackPositions = absoluteAttackPositions(getNextTargetPos(original_pos / GameData.TileSize, turnBehaviour.attackDirection), turnBehaviour.attackDirection)
	
	for i in range(0, attackPositions.size()):
		var attackPosition = attackPositions[i]
		
		if (i > 0):
			var timer = Timer.new()
			timer.set_wait_time(0.2 * i)
			timer.connect("timeout", self, "AddHeavyImpact", [attackPosition * GameData.TileSize]) 
			timer.set_one_shot(true)
			add_child(timer)
			timer.start()
		else:
			AddHeavyImpact(attackPosition * GameData.TileSize)

func AddHeavyImpact(position):
	var heavyImpactInstance = HeavyImpact.instance()
		
	heavyImpactInstance.position = position
	EffectsNode.add_child(heavyImpactInstance)
	heavyImpactInstance.play()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()

func handleCharacterDeath():
	self.get_node("Stars").hide()
	.handleCharacterDeath()