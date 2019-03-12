extends "Character.gd"

var attack
var character_name = 'Unset'
var item_distribution
var base_damage = 1

func _ready():
	set_process(true)
	GameData.characters.append(self)
	self.get_node("/root/Node2D").connectEnemy(self)

func attack(character):
	.attack(character, base_damage);
	
func turn():
	pass

func _process(delta):
	pass

func handleCharacterDeath():
	dropItem()

	.handleCharacterDeath()

func dropItem():
	if(item_distribution != null):
		for pickedItem in item_distribution.pick():
			var item = pickedItem.new()
			item.place(get_position())

