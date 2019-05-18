extends "Character.gd"

var attack
var character_name = 'Unset'
var item_distribution
var base_damage = 1
var processBehaviour
var turnBehaviour
var previous_movement_direction = Enums.DIRECTION.DOWN

func _ready():
	set_process(true)
	GameData.characters.append(self)
	self.get_node("/root/Node2D").connectEnemy(self)

func attack(character):
	.attack(character, base_damage);
	

func turn():
	if movement_direction != Enums.DIRECTION.NONE:
		previous_movement_direction = movement_direction
	moving = moveDirection(turnBehaviour.getDirection(original_pos))
	print("HERE: moving: ", moving, ", direction: ", movement_direction)
	if moving:
		if movement_direction != Enums.DIRECTION.NONE:
			setWalkAnimation(movement_direction)
		else:
			setStandAnimation(previous_movement_direction)

func _process(delta):
	var state = processBehaviour.getNewState(get_position(), original_pos, movement_direction, moving, delta)
	if state[0] != null:
		self.set_position(state[0])
	if self.moving and !state[1]:
		original_pos = get_position()
		if previous_movement_direction != Enums.DIRECTION.NONE:
			setStandAnimation(previous_movement_direction)
		else:
			setStandAnimation(Enums.DIRECTION.STAND_DOWN)
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