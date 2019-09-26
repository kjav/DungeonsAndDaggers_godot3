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
const headXUpPosition = 18.6549

var changingBodyParts
var leftArm
var rightArm
var head
var body
var leftArmAngerOverlay
var rightArmAngerOverlay
var headAngerOverlay
var bodyAngerOverlay

var headFrameSize

var EffectsNode
var stageOneDefeated
var alternateAttackCue
var visualAttackCueActive
var currentFlip_hState
var walkingUp

func _ready():
	EffectsNode = get_node("/root/Node2D/Effects")
	turnBehaviour = Turn.MoveToSignalBeforeAttackRecoverIfMissed.new()
	processBehaviour = Process.Direct.new()
	self.character_name = 'Boss Ogre'
	base_damage = 3
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.FoodClasses.CookedSteak}])
	self.get_node("Stars").hide()
	stageOneDefeated = false
	alternateAttackCue = false
	visualAttackCueActive = false
	currentFlip_hState = false
	walkingUp = false
	
	turnBehaviour.LeaveWaitAttackWaitSequence()

	changingBodyParts = get_node("ChangingBodyParts")
	leftArm = changingBodyParts.get_node("Left Arm")
	rightArm = changingBodyParts.get_node("Right Arm")
	head = changingBodyParts.get_node("Head")
	body = changingBodyParts.get_node("Body")
	leftArmAngerOverlay = changingBodyParts.get_node("Left Arm Anger Overlay")
	rightArmAngerOverlay = changingBodyParts.get_node("Right Arm Anger Overlay")
	headAngerOverlay = changingBodyParts.get_node("Head Anger Overlay")
	bodyAngerOverlay = changingBodyParts.get_node("Body Anger Overlay")
	
	
	additionalRelativeAttackPositions = []
	turnBehaviour.additionalRelativeAttackPositions = []
	
	leftArmAngerOverlay.hide()
	rightArmAngerOverlay.hide()
	headAngerOverlay.hide()
	bodyAngerOverlay.hide()
	
	headFrameSize = head.frames.get_frame("stand_left", 0).get_size()
	
	initialStats.health = {
		"value": 12,
		"maximum": 24
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
		
		stand_direction = turnBehaviour.attackDirection
		previous_stand_direction = turnBehaviour.attackDirection
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
			leftArmAngerOverlay.set_flip_h( false )
			rightArm.set_flip_h( true )
			rightArmAngerOverlay.set_flip_h( true )
			
			if walkingUp:
				leftArm.position.x -= leftArm.frames.get_frame("stand_left", 0).get_size().x
				leftArmAngerOverlay.position.x -= leftArm.frames.get_frame("stand_left", 0).get_size().x
		else:
			leftArm.set_flip_h( currentFlip_hState )
			leftArmAngerOverlay.set_flip_h( currentFlip_hState )
			rightArm.set_flip_h( currentFlip_hState )
			rightArmAngerOverlay.set_flip_h( currentFlip_hState )
	
	leftArm.set_flip_v( visualAttackCueActive )
	leftArmAngerOverlay.set_flip_v( visualAttackCueActive )
	rightArm.set_flip_v( visualAttackCueActive )
	rightArmAngerOverlay.set_flip_v( visualAttackCueActive )

func addHeavyImpacts():
	var attackPositions = PositionHelper.absoluteAttackPositions(PositionHelper.getNextTargetPos(original_pos / GameData.TileSize, turnBehaviour.attackDirection), additionalRelativeAttackPositions, turnBehaviour.attackDirection)
	
	for i in range(0, attackPositions.size()):
		var attackPosition = attackPositions[i]
		
		GameData.player.get_node("Camera2D").shake(0.2, 20, 40)
		
		if (i > 0):
			var timer = Timer.new()
			timer.set_wait_time(0.2 * i)
			timer.connect("timeout", self, "AddHeavyImpact", [attackPosition * GameData.TileSize]) 
			timer.set_one_shot(true)
			add_child(timer)
			timer.start()
		else:
			AddHeavyImpact(attackPosition * GameData.TileSize)

func getHeadLeftTopPosition():
	return Vector2(head.position.x - headFrameSize.x / 2, head.position.y - headFrameSize.y / 2)

func getHeadLeftMiddlePosition():
	return Vector2(head.position.x - headFrameSize.x / 2, head.position.y)

func getHeadRightTopPosition():
	return Vector2(head.position.x + headFrameSize.x / 2, head.position.y - headFrameSize.y / 2)

func getHeadRightMiddlePosition():
	return Vector2(head.position.x + headFrameSize.x / 2, head.position.y)

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
		changingBodyParts.move_child(bodyAngerOverlay, 0)
		changingBodyParts.move_child(body, 0)
		adjustPositonForFacingDown()
	
	setVisualAttackCues()

func adjustPositonForWalkingUp():	
	head.position.x = headXUpPosition
	headAngerOverlay.position.x = headXUpPosition
	leftArm.position.x = leftArmXUpPosition
	leftArmAngerOverlay.position.x = leftArmXUpPosition
	rightArm.position.x = rightArmXUpPosition
	rightArmAngerOverlay.position.x = rightArmXUpPosition
	
	changingBodyParts.move_child(body, changingBodyParts.get_child_count()-1)
	changingBodyParts.move_child(bodyAngerOverlay, changingBodyParts.get_child_count()-1)

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
	leftArmAngerOverlay.position.x = plannedLeftArmXPosition
	rightArm.position.x = plannedRightArmXPosition
	rightArmAngerOverlay.position.x = plannedRightArmXPosition
	head.position.x = plannedHeadArmXPosition
	headAngerOverlay.position.x = plannedHeadArmXPosition

func handleCharacterDeath():
	self.get_node("Stars").hide()
	turnBehaviour.LeaveWaitAttackWaitSequence()
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(12, true)
		
		addAngerMark(getHeadLeftTopPosition(), PI/4)
		addAngerMark(getHeadLeftMiddlePosition(), PI/16)
		addAngerMark(getHeadRightTopPosition(), PI*3/4)
		addAngerMark(getHeadRightMiddlePosition(), PI*15/16)
		
		leftArmAngerOverlay.show()
		rightArmAngerOverlay.show()
		headAngerOverlay.show()
		bodyAngerOverlay.show()

func addAngerMark(position, rotation):
	var angerMark = AngerMark.instance()
	
	angerMark.setRotation(rotation)
	angerMark.position = position
	
	self.add_child(angerMark)