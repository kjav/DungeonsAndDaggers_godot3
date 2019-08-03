extends "Character.gd"

var attack
var character_name = 'Unset'
var item_distribution
var base_damage = 1
var processBehaviour
var turnBehaviour
var previous_stand_direction = Enums.DIRECTION.DOWN

func _enter_tree():
	GameData.characters.append(self)
	
func _ready():
	set_process(true)
	self.get_node("/root/Node2D").connectEnemy(self)
	._ready()

func attack(character):
	.attack(character, base_damage);
	

func turn():
	if movement_direction != Enums.DIRECTION.NONE:
		previous_stand_direction = movement_direction
	moving = moveDirection(turnBehaviour.turn(original_pos))
	if moving:
		if movement_direction != Enums.DIRECTION.NONE:
			setWalkAnimation(movement_direction)
		else:
			setStandAnimation(previous_stand_direction)
	
	turnBehaviour.afterMoveComplete(original_pos)

func _process(delta):
	var state = processBehaviour.getNewState(get_position(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_position(state[0])
	if self.moving and !state[1]:
		original_pos = get_position()
		if stand_direction != Enums.DIRECTION.NONE:
			setStandAnimation(stand_direction)
		else:
			setStandAnimation(previous_stand_direction)
	if state[1] != null:
		self.moving = state[1]

func handleCharacterDeath():
	dropItem()
	.handleCharacterDeath()

func dropItem():
	if(item_distribution != null):
		for pickedItem in item_distribution.pick():
			var item = pickedItem.value.new()
			item.place(get_position())
