extends Node2D

var EventMessage = load("res://Hud/EventMessage.tscn")
const maximumMessagesToShow = 10

func _ready():
	GameData.player.connect("healthChanged", self, "PlayerHealthChanged")
	pass

func _on_Environment_unlocked(environmentObjectsName):
	addMessage('You unlocked a ' + str(environmentObjectsName) + '.');

func _on_Player_healthRaised(value):
	addMessage('You healed: ' + str(value) + '.');

func _on_Player_itemPickedUp( item ):
	addMessage('You obtained a ' + item.item_name + item.typeNameForMessage + '.');

func _on_Player_weaponChanged( slot, weapon ):
	if (slot == Enums.WEAPONSLOT.PRIMARY):
		addMessage('A ' + weapon.item_name + ' is now equipped.');

func _on_Player_playerAttack( character, amount ):
	if character == GameData.player:
		addMessage('You hurt yourself: ' + str(amount) + '.');
	else:
		addMessage('You hurt a ' + character.character_name + ': ' + str(amount) + '.');

func _on_Enemy_attack( character, amount ):
	var potentiallyFreedCharacter = weakref(character)
	
	if potentiallyFreedCharacter.get_ref():
		addMessage('A ' + character.character_name + ' hurt you: ' + str(amount) + '.');

func _on_Timer_timeout(node):
	removeChild(node);

func _on_FoodItem_used(item):
	addItemMessage(item, "You ate a ", item.typeNameForMessage);
	
func _on_PotItem_used(item):
	addItemMessage(item, "You drank a ", item.typeNameForMessage);
	
func _on_SpellItem_used(item):
	addItemMessage(item, "You cast a ", item.typeNameForMessage);

func addItemMessage(item, messagePretext, messagePostText):
	addMessage(messagePretext + str(item.item_name) + messagePostText + '.');

func createEventMessageNode(y_pos, text):
	var instance = EventMessage.instance();
	instance.set_position(Vector2(0, y_pos));
	instance.set_text(text);
	instance.connect("timeout", self, "on_Timer_timeout");

	return instance;

func addMessage(text):
	var y_pos = 0;

	if(self.get_child_count() > maximumMessagesToShow):
		removeChild(0);
	
	if(self.get_child_count() > 0):
		y_pos = getLastYPosition();
	
	self.add_child(createEventMessageNode(y_pos, text));

func getLastYPosition():
	var y_pos = self.get_child(self.get_child_count()-1).get_position().y;
	y_pos += self.get_child(self.get_child_count()-1).get_height();

	return y_pos;

func removeChild(child):
	if (TYPE_INT == typeof(child)):
		child = self.get_child(child)
	
	child.remove();
	self.remove_child(child);
	reposition(-child.get_height());

func reposition(height):
	for item in self.get_children():
		if item is Node2D:
			item.set_position(item.get_position() + Vector2(0, height));


