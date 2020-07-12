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
var alternateAttackCue
var visualAttackCueActive

func _init():
	self.character_name = 'Undead Dragon'

	item_distribution = Constants.IndependentDistribution.new([
		{ "p": 1, "value": Constants.Distribution.new([
			{ "p": 0.5, "value": Constants.UncommonWeaponsDistribution.pick()[0].value }, 
			{ "p": 0.35, "value": Constants.RareWeaponsDistribution.pick()[0].value },
			{ "p": 0.15, "value": Constants.WeaponClasses.OgreArm }
		]).pick()[0].value }, 
		{ "p": 1, "value": Constants.SpellClasses.EarthquakeSpell },
		{ "p": 1, "value": Constants.PotionClasses.LevelUpPotion },
		{ "p": 1, "value": Constants.Distribution.new([
			{ "p": 0.6, "value": Constants.UncommonFoodsDistribution.pick()[0].value }, 
			{ "p": 0.4, "value": Constants.RareFoodsDistribution.pick()[0].value }
		]).pick()[0].value }, 
		{ "p": 0.6, "value": Constants.AllUncommonPotionsSpellsDistribution.pick()[0].value },
		{ "p": 0.3, "value": Constants.AllRarePotionsSpellsDistribution.pick()[0].value }
	])

func _ready():
	EffectsNode = get_node("/root/Node2D/Effects")
	turnBehaviour = Turn.MoveToSignalBeforeAttackRecoverIfMissed.new(self)
	processBehaviour = Process.Direct.new()
	self.get_node("Stars").hide()
	stageOneDefeated = false
	alternateAttackCue = false
	visualAttackCueActive = false
	
	turnBehaviour.LeaveWaitAttackWaitSequence()

	changingBodyParts = get_node("ChangingBodyParts")
	body = changingBodyParts.get_node("Body")
	additionalRelativeAttackPositions = []
	turnBehaviour.additionalRelativeAttackPositions = []
	
	setBaseDamage(2)
	setInitialHealth(8, 16, 8)
	setInitialStats(3.5, 3.5, 3.5, 3.5)
	
	._ready()

func turn(skipTurnBehaviour = false):
	if stunnedDuration <= 0:
		.turnWithNoAfterMoveComplete()
		if (turnBehaviour.Attacking()):
			addHeavyImpacts()
			
			visualAttackCueActive = false
			setVisualAttackCues()
			
			turnBehaviour.additionalRelativeAttackPositions = []
			additionalRelativeAttackPositions = []
		
		.afterMoveComplete()
		
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
	else:
		.turn()

func setVisualAttackCues():
	if alternateAttackCue:
		if visualAttackCueActive:
			pass
	#set visual cue 

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

func AddHeavyImpact(position):
	var heavyImpactInstance = HeavyImpact.instance()
	
	heavyImpactInstance.position = position
	EffectsNode.add_child(heavyImpactInstance)
	heavyImpactInstance.play()

func resetToStartPosition():
	self.position = initial_pos
	
	_ready()

func setWalkAnimation(direction):
	.setWalkAnimation(direction)
	
	setVisualAttackCues()

func faceDirecion(direction):
	.faceDirecion(direction)
	
	setVisualAttackCues()

func setStandAnimation(direction):
	.setStandAnimation(direction)
	
	setVisualAttackCues()

func handleCharacterDeath():
	self.get_node("Stars").hide()
	turnBehaviour.LeaveWaitAttackWaitSequence()
	
	if (stageOneDefeated):
		.handleCharacterDeath()
	else:
		stageOneDefeated = true
		.heal(300, true)
		#style for

func deathWinConditionMet():
	return !anyOtherBossesRemaining() && GameData.current_level == GameData.bossLevelEvery * 2
