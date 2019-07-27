extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://Effects/HeavyImpact.tscn")
const AngerMark = preload("res://Effects/AngerMark.tscn")

const leftArmXInitialPosition = 3.96536
const rightArmXInitialPosition = 14.6453
const headXInitialPosition = 13.6549

const leftArmXFlippedPosition = 21.96536
const rightArmXFlippedPosition = 11.6453
const headXFlippedPosition = 18.6549

const leftArmXUpPosition  = 6.6453
const rightArmXUpPosition = 23.96536
const headXUpPosition = 21.6549

var changingBodyParts
var leftArm
var rightArm
var head

var EffectsNode
var stageOneDefeated
var alternateAttackCue
var visualAttackCueActive
var currentFlip_hState
var walkingUp

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
	currentFlip_hState = false
	walkingUp = false

	changingBodyParts = get_node("ChangingBodyParts")
	leftArm = changingBodyParts.get_node("Left Arm")
	rightArm = changingBodyParts.get_node("Right Arm")
	head = changingBodyParts.get_node("Head")
	
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
	if alternateAttackCue:
		if visualAttackCueActive:
			leftArm.set_flip_h( false )
			rightArm.set_flip_h( true )
			if walkingUp:
				leftArm.position.x -= leftArm.frames.get_frame("stand_left", 0).get_size().x
		else:
			leftArm.set_flip_h( currentFlip_hState )
			rightArm.set_flip_h( currentFlip_hState )
	
	leftArm.set_flip_v( visualAttackCueActive )
	rightArm.set_flip_v( visualAttackCueActive )

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
	walkingUp = false
	
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("walk_up")
			walkingUp = true
			currentFlip_hState = true
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("walk_left")
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("walk_left")
			currentFlip_hState = false
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("walk_left")
			currentFlip_hState = true
	
	adjustBosyPositions()

func setStandAnimation(direction):
	walkingUp = false
	
	match direction:
		Enums.DIRECTION.UP:
			setAnimationOnAllBodyParts("stand_up")
			walkingUp = true
			currentFlip_hState = true
		Enums.DIRECTION.DOWN:
			setAnimationOnAllBodyParts("stand_left")
		Enums.DIRECTION.LEFT:
			setAnimationOnAllBodyParts("stand_left")
			currentFlip_hState = false
		Enums.DIRECTION.RIGHT:
			setAnimationOnAllBodyParts("stand_left")
			currentFlip_hState = true
	
	adjustBosyPositions()

func adjustBosyPositions():
	setFlip_hOnAllBodyParts(currentFlip_hState)
	
	if (walkingUp):
		adjustPositonForWalkingUp()
	else:
		changingBodyParts.move_child(changingBodyParts.get_node("Body"), 0)
		adjustPositonForFacingDown()
	
	setVisualAttackCues()

func adjustPositonForWalkingUp():	
	head.position.x = headXUpPosition
	leftArm.position.x = leftArmXUpPosition
	rightArm.position.x = rightArmXUpPosition
	
	changingBodyParts.move_child(changingBodyParts.get_node("Body"), 3)

func adjustPositonForFacingDown():
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
	
	leftArm.position.x = plannedLeftArmXPosition
	rightArm.position.x = plannedRightArmXPosition
	head.position.x = plannedHeadArmXPosition

func handleCharacterDeath():
	self.get_node("Stars").hide()
	turnBehaviour.LeaveWaitAttackWaitSequence()
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(12)

func addAngerMark(relativePosition, rotation):
	var angerMark = AngerMark.instance()
	
	angerMark.setRotation(rotation)
	angerMark.position = self.position + relativePosition
	
	EffectsNode.add_child(angerMark)