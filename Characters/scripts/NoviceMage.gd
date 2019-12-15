extends "Enemy.gd"

const Turn = preload("res://Characters/scripts/behaviours/Turn.gd")
const Process = preload("res://Characters/scripts/behaviours/_Process.gd")
const missile = preload("res://Projectiles/Missile.tscn")
const missile_texture = preload("res://assets/pellet.png")
var moveTo
var attackedLastTurn

func _init():
	self.character_name = 'Novice Mage'
	item_distribution = Constants.IndependentDistribution.new([{"p": 1, "value": Constants.SpellClasses.MissileSpell}])

func _ready():
	moveTo = Turn.MoveTo.new(self)
	turnBehaviour = Turn.InRangeMoveToOtherwiseRandomWaitEveryNTurns.new(self)
	processBehaviour = Process.Direct.new()
	base_damage = 0
	turnBehaviour.setWaitEvery(2)
	attackedLastTurn = false
	
	._ready()


func turn(skipTurnBehaviour = false):
	if stunnedDuration <= 0 && alive() && pathFindingWithinBounds(moveTo.getPathFindingDistance(original_pos)):
		if !attackedLastTurn:
			attackedLastTurn = true
			
			castMissile()
		else:
			attackedLastTurn = false
		
		.turn(true)
	else:
		attackedLastTurn = false
		.turn()

func pathFindingWithinBounds(distance):
	return distance != -1 && distance <= 4

func castMissile():
	GameData.hud.addEventMessage(character_name + " cast a missile at you!")
	
	var new_missile = missile.instance()
	#Audio.playSoundEffect("Missile_Flying")
	self.get_parent().add_child(new_missile)
	
	new_missile.init(
		GameData.player.get_path(),
		missile_texture,
		get_position() + Vector2(GameData.TileSize/2, GameData.TileSize/2),
		25,
		0.5,
		"Missile_Hit",
		Vector2(0.2, 0.2)
	)