extends Node2D

var associatedSprites = {}

func _ready():
	for i in GameData.placedItems:
		addItem(i)
	GameData.connect("itemDropped", self, "addItem")
	GameData.connect("itemPickedUp", self, "remove")

func setupConnection():
	GameData.player.connect("itemPickedUp", self, "remove")

func remove(item):
	var sprite = associatedSprites[item.get_instance_id()]
	
	if sprite != null:
		sprite.hide()
		sprite.queue_free()

func addItem(newItem):
	var s = Sprite.new()
	
	if newItem.get("rotationInOffHand") != null:
		s.set_texture(newItem.rotationInOffHand)
	else:
		s.set_texture(newItem.texture)
	
	s.set_scale(Vector2(0.5, 0.5))
	s.set_position(newItem.position + Vector2(64,64))
	add_child(s)
	associatedSprites[newItem.get_instance_id()] = s

