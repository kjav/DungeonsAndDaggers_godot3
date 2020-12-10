extends "Boss.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const HeavyImpact = preload("res://VisualEffects/HeavyImpact.tscn")
const AngerMark = preload("res://VisualEffects/AngerMark.tscn")

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

var attacksRelativePositions = []

func _init():
	self.character_name = 'Undead Dragon'

	item_distribution = Constants.IndependentDistribution.new([
		{ "p": 1, "value": Constants.Distribution.new([
			{ "p": 0.6, "value": Constants.UncommonWeaponsDistribution.pick()[0].value }, 
			{ "p": 0.4, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value }, 
		{ "p": 0.2, "value": Constants.Distribution.new([
			{ "p": 0.6, "value": Constants.UncommonWeaponsDistribution.pick()[0].value }, 
			{ "p": 0.4, "value": Constants.RareWeaponsDistribution.pick()[0].value }
		]).pick()[0].value }, 
		{ "p": 0.9, "value": Constants.SpellClasses.FireSpell },
		{ "p": 1, "value": Constants.PotionClasses.LevelUpPotion },
		{ "p": 1, "value": Constants.Distribution.new([
			{ "p": 0.6, "value": Constants.UncommonFoodsDistribution.pick()[0].value }, 
			{ "p": 0.4, "value": Constants.RareFoodsDistribution.pick()[0].value }
		]).pick()[0].value }, 
		{ "p": 0.8, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
		{ "p": 0.4, "value": Constants.RareFoodsDistribution.pick()[0].value }
	])

func _ready():
	EffectsNode = get_node("/root/Node2D/Effects")
	turnBehaviour = Turn.MoveToSignalBeforeAttackRecoverIfMissed.new(self)
	processBehaviour = Process.Direct.new()
	self.get_node("Stars").hide()
	stageOneDefeated = false
	
	turnBehaviour.LeaveWaitAttackWaitSequence()

	changingBodyParts = get_node("ChangingBodyParts")
	body = changingBodyParts.get_node("Body")
	additionalRelativeAttackPositions = []
	turnBehaviour.additionalRelativeAttackPositions = []
	
	setBaseDamage(2)
	setInitialHealth(10, 20, 10)
	setInitialStats(3, 3, 3, 3, 1.5)
	
	._ready()

func turn(skipTurnBehaviour = false):
	if stunnedDuration <= 0:
		.turnWithNoAfterMoveComplete()
		if (turnBehaviour.Attacking()):
			attacksRelativePositions = additionalRelativeAttackPositions
			turnBehaviour.additionalRelativeAttackPositions = []
			additionalRelativeAttackPositions = []
		
		.afterMoveComplete()
		
		if (turnBehaviour.PreparingAttack()):
			var currentAdditionalRelativeAttacks
			
			stand_direction = turnBehaviour.attackDirection
			previous_stand_direction = turnBehaviour.attackDirection
			
			if (stageOneDefeated):
				if (randi() % 2 == 1):
					showFrontWarningFlames(true)
					currentAdditionalRelativeAttacks = [Vector2(0, -1)]
				else:
					showFrontWarningFlames(false)
					currentAdditionalRelativeAttacks = [Vector2(-1, 0), Vector2(1, 0)]
			else:
				showFrontWarningFlames(true)
				currentAdditionalRelativeAttacks = [Vector2(0, -1)]
			
			additionalRelativeAttackPositions = currentAdditionalRelativeAttacks
			turnBehaviour.additionalRelativeAttackPositions = currentAdditionalRelativeAttacks
		
		if (turnBehaviour.Attacking()):
			setWalkAnimation(previous_stand_direction)
	else:
		.turn()

func showFrontWarningFlames(isFront):
	get_node("ChangingBodyParts/ForwardFlameFront").visible = isFront
	get_node("ChangingBodyParts/ForwardFlameBehind").visible = isFront
	get_node("ChangingBodyParts/SideFlameFront").visible = !isFront
	get_node("ChangingBodyParts/SideFlameBehind").visible = !isFront

func addHeavyImpacts():
	var attackPositions = PositionHelper.absoluteAttackPositions(PositionHelper.getNextTargetPos(original_pos / GameData.TileSize, turnBehaviour.attackDirection), attacksRelativePositions, turnBehaviour.attackDirection)
	
	setDirectionAnimation(turnBehaviour.attackDirection, "stand")
	
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

func AddHeavyImpact(position):
	var heavyImpactInstance = HeavyImpact.instance()
	
	heavyImpactInstance.position = position
	EffectsNode.add_child(heavyImpactInstance)
	heavyImpactInstance.play()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()

func setWalkAnimation(direction):
	if(not "prepare" in currentAnimationName):
		if(turnBehaviour.Attacking()):
			.setWalkAnimation(turnBehaviour.attackDirection)
		elif turnBehaviour.PreparingAttack():
			setPrepareAttackAnimation(direction)
		else:
			.setWalkAnimation(direction)

func faceDirection(direction):
	if(not "prepare" in currentAnimationName):
		if(turnBehaviour.Attacking()):
			.faceDirection(turnBehaviour.attackDirection)
		elif turnBehaviour.PreparingAttack():
			setPrepareAttackAnimation(direction)
		else:
			.faceDirection(direction)

func triggerAttackAnimations():
	setDirectionAnimationAfterCurrentFinishes(turnBehaviour.attackDirection, "attack")
	get_node(bodyPartsNodeName).get_children()[0].connect("animation_finished",self,"setHeavyImpactsAfterAnimationFinishes", [], CONNECT_ONESHOT)

func setHeavyImpactsAfterAnimationFinishes():
	get_node(bodyPartsNodeName).get_children()[0].connect("animation_finished",self,"addHeavyImpacts", [], CONNECT_ONESHOT)

func setStandAnimation(direction):
	if(not "prepare" in currentAnimationName):
		if(turnBehaviour.Attacking()):
			.setStandAnimation(turnBehaviour.attackDirection)
		elif turnBehaviour.PreparingAttack():
			setPrepareAttackAnimation(direction)
		else:
			.setStandAnimation(direction)

func setPrepareAttackAnimation(direction):
	setDirectionAnimation(direction, "prepare")

func handleCharacterDeath():
	self.get_node("Stars").hide()
	turnBehaviour.LeaveWaitAttackWaitSequence()
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(300, true)
		get_node("BloodExplosion").show()
		get_node("BloodExplosion").explode()
		get_node("ChangingBodyParts/Body").set_modulate(Color("#c76868"))

func deathWinConditionMet():
	return !anyOtherBossesRemaining() && GameData.current_level == GameData.bossLevelEvery * 2

func setAnimationOnAllBodyParts(animationName, setEvenIfDead = false):
	var unchangedCurrentAnimationName = currentAnimationName
	
	.setAnimationOnAllBodyParts(animationName, setEvenIfDead)
	
	if (alive() or setEvenIfDead) and unchangedCurrentAnimationName != animationName:
		if "prepare" in animationName:
			setAnimationOnEachFlameSprite(animationName)
		else:
			setAnimationOnEachFlameSprite("none")

func setAnimationOnEachFlameSprite(animationName):
			get_node("ChangingBodyParts/SideFlameBehind").set_animation(animationName)
			get_node("ChangingBodyParts/SideFlameFront").set_animation(animationName)
			get_node("ChangingBodyParts/ForwardFlameBehind").set_animation(animationName)
			get_node("ChangingBodyParts/ForwardFlameFront").set_animation(animationName)
