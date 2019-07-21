extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
var EffectsNode
var stageOneDefeated
var alternateAttackCue
var visualAttackCueActive
var currentFlip_hState
var leftArmXInitialPosition = 3.96536
var rightArmXInitialPosition = 14.6453
var headXInitialPosition = 13.6549
var leftArmXFlippedPosition = 21.96536
var rightArmXFlippedPosition = 11.6453
var headXFlippedPosition = 18.6549

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
	visualAttackCueActive = false
	
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
		
		visualAttackCueActive = true
		setVisualAttackCues()
	elif (turnBehaviour.Attacking()):
		addHeavyImpacts()
		
		visualAttackCueActive = false
		setVisualAttackCues()
		
		turnBehaviour.additionalRelativeAttackPositions = []
		additionalRelativeAttackPositions = []

func setVisualAttackCues():
	var changingBodyParts = get_node("ChangingBodyParts")
	
	if alternateAttackCue:
		if visualAttackCueActive:
			changingBodyParts.get_node("Left Arm").set_flip_h( false )
			changingBodyParts.get_node("Right Arm").set_flip_h( true )
		else:
			changingBodyParts.get_node("Left Arm").set_flip_h( currentFlip_hState )
			changingBodyParts.get_node("Right Arm").set_flip_h( currentFlip_hState )
	
	changingBodyParts.get_node("Left Arm").set_flip_v( visualAttackCueActive )
	changingBodyParts.get_node("Right Arm").set_flip_v( visualAttackCueActive )

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

func setWalkAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("walk_up")
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("walk_down")
			currentFlip_hState = false
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("walk_left")
			currentFlip_hState = false
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("walk_right")
			currentFlip_hState = true
	
	setFlip_hOnAllBodyParts(currentFlip_hState)
	adjustPositonForFlip()
	setVisualAttackCues()

func setStandAnimation(direction):
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("stand_up")
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("stand_down")
			currentFlip_hState = false
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("stand_left")
			currentFlip_hState = false
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("stand_right")
			currentFlip_hState = true
	
	setFlip_hOnAllBodyParts(currentFlip_hState)
	adjustPositonForFlip()
	setVisualAttackCues()

func adjustPositonForFlip():
	var plannedLeftArmXPosition
	var plannedRightArmXPosition
	var plannedHeadArmXPosition
	
	if currentFlip_hState:
		plannedLeftArmXPosition = leftArmXFlippedPosition
		plannedRightArmXPosition = rightArmXFlippedPosition
		plannedHeadArmXPosition = headXFlippedPosition
	else:
		plannedLeftArmXPosition = leftArmXInitialPosition
		plannedRightArmXPosition = rightArmXInitialPosition
		plannedHeadArmXPosition = headXInitialPosition
	
	var changingBodyParts = get_node("ChangingBodyParts")
	
	changingBodyParts.get_node("Left Arm").position.x = plannedLeftArmXPosition
	changingBodyParts.get_node("Right Arm").position.x = plannedRightArmXPosition
	changingBodyParts.get_node("Head").position.x = plannedHeadArmXPosition

func handleCharacterDeath():
	self.get_node("Stars").hide()
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(12)