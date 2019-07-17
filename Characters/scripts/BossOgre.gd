extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
var EffectsNode
var stageOneDefeated
var alternateAttackCue

func _ready():
	EffectsNode = get_node("/root/Node2D/Effects")
	turnBehaviour = Turn.MoveToWaitBeforeAttackRecoverIfMissed.new()
	processBehaviour = Process.StraightTransition.new()
	self.character_name = 'Boss Ogre'
	base_damage = 3
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.CookedSteak}])
	self.get_node("Stars").hide()
	stageOneDefeated = false
	alternateAttackCue = false
	
	initialStats.health = {
		"value": 12,
		"maximum": 12
	}
	
	._ready()

func turn():
	.turn()
	
	if (!turnBehaviour.Recovering()):
		self.get_node("Stars").hide()
	else:
		self.get_node("Stars").show()
	
	if (turnBehaviour.PreparingAttack()):
		var currentAdditionalRelativeAttacks
		alternateAttackCue = false
		
		if (stageOneDefeated):
			if (randi() % 2 == 1):
				currentAdditionalRelativeAttacks = [Vector2(0, -1)]
			else:
				currentAdditionalRelativeAttacks = [Vector2(-1, 0), Vector2(1, 0)]
				alternateAttackCue = true
		else:
			currentAdditionalRelativeAttacks = [Vector2(0, -1)]
		
		additionalRelativeAttackPositions = currentAdditionalRelativeAttacks
		turnBehaviour.additionalRelativeAttackPositions = currentAdditionalRelativeAttacks
		
		changeVisualAttackCues(alternateAttackCue, true)
	elif (turnBehaviour.Attacking()):
		addHeavyImpacts()
		changeVisualAttackCues(alternateAttackCue, false)
		
		turnBehaviour.additionalRelativeAttackPositions = []
		additionalRelativeAttackPositions = []

func changeVisualAttackCues(alternateAttackCue, active):
	var changingBodyParts = get_node("ChangingBodyParts")
	
	if alternateAttackCue:
		changingBodyParts.get_node("Left Arm").set_flip_h( active )
		changingBodyParts.get_node("Right Arm").set_flip_h( active )
	else:
		changingBodyParts.get_node("Left Arm").set_flip_v( active )
		changingBodyParts.get_node("Right Arm").set_flip_v( active )

func addHeavyImpacts():
	var attackPositions = PositionHelper.absoluteAttackPositions(PositionHelper.getNextTargetPos(original_pos / GameData.TileSize, turnBehaviour.attackDirection), additionalRelativeAttackPositions, turnBehaviour.attackDirection)
	
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
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(12)