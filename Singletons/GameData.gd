extends Node

signal itemDropped(item)
signal itemPickedUp(item)

var potions = []
var foods = []
var spells = []
var keys = []
var tilemap
var chosen_player
var player
var hud
var chosen_map
var characters = []
var environmentObjects = []
var placedItems = []
var TileSize = 128;
var start_screen = "world_select"
var effectsNode
var current_level = 1
var muted = check_muted()
var commonBackground = preload("res://assets//ring_inner_grey.png")
var uncommonBackground = preload("res://assets//ring_inner_green.png")
var rareBackground = preload("res://assets//ring_inner_blue.png")
var bossLevelEvery = 6

var saved_player = null

var map_seed = null

func _ready():
	randomize()
	#addInitialItemsForTesting()
	map_seed = randi()

func addInitialItemsForTesting():
	var instance = Constants.PotionClasses.HealthPotion.new()
	var instance2 = Constants.PotionClasses.DoubleDamagePotion.new()
	var instance3 = Constants.PotionClasses.InvisibilityPotion.new()
	var instance4 = Constants.PotionClasses.LevelUpPotion.new()
	var instance5 = Constants.PotionClasses.BriefHealthPotion.new()
	var instance6 = Constants.PotionClasses.BriefStrengthPotion.new()
	var instance7 = Constants.PotionClasses.BriefDefencePotion.new()
	
	addPotions([instance, instance2, instance3, instance4, instance5, instance6, instance7])
	
	instance = Constants.FoodClasses.CookedSteak.new()
	instance2 = Constants.FoodClasses.Cheese.new()
	instance3 = Constants.FoodClasses.Apple.new()
	
	addFoods([instance, instance2, instance3])
	
	instance = Constants.SpellClasses.FireSpell.new()
	instance2 = Constants.SpellClasses.RepelSpell.new()
	instance3 = Constants.SpellClasses.EarthquakeSpell.new()
	instance4 = Constants.SpellClasses.TeleportSpell.new()
	instance5 = Constants.SpellClasses.MissileSpell.new()
	instance6 = Constants.SpellClasses.StunSpell.new()
	addSpells([instance, instance2, instance3, instance4, instance5, instance6])

func addKey(new_key):
	keys.append(new_key)

func getBackgroundForRarity(rarity):
	if rarity == Enums.WEAPONRARITY.COMMON:
		return commonBackground
	if rarity == Enums.WEAPONRARITY.UNCOMMON:
		return uncommonBackground
	if rarity == Enums.WEAPONRARITY.RARE:
		return rareBackground

func addPotions(new_potions):
	for potion in new_potions:
		potions.append(potion)

func addFoods(new_foods):
	for food in new_foods:
		foods.append(food)

func addSpells(new_spells):
	for spell in new_spells:
		spells.append(spell)

func RemoveEnvironment(environmentObjectToRemove):
	environmentObjects.remove(environmentObjects.find(environmentObjectToRemove))

func RemoveKey(unlockGuid):
	for i in range(keys.size()-1, -1, -1):
		#in the future when we save the current floor this should pass that aswell
		if keys[i].IsValidKey(unlockGuid):
			keys.remove(i)
			return

func HasKey(unlockGuid):
	for i in range(keys.size()-1, -1, -1):
		#in the future when we save the current floor this should pass that aswell
		if keys[i].IsValidKey(unlockGuid):
			return keys[i]

func charactersMoving():
	#at the moment all characters move at the same speed so this is cutting corners
	if characters.size() <= 0:
		return false;
	
	return characters[0].moving

func charactersAtPosExcludingCharacter(pos, character):
	var possibleCharacters = charactersAtPos(pos)
	
	for i in range(possibleCharacters.size()):
		if possibleCharacters[i] == character:
			possibleCharacters.remove(i)
	
	return possibleCharacters

func charactersAtPos(pos):
	return arrayAtPosForMoving(pos, characters)

func environmentBlocksAttack(pos):
	var environmentObjectAtPos = environmentObjectAtPos(pos)
	
	for environmentObject in environmentObjectAtPos:
		if environmentObject.blocksAttacks:
			return true
	
	return false

func arrayAtPosForMoving(pos, array):
	var collisions = []
	
	for i in range(array.size()):
		var other_target_pos = Vector2(array[i].target_pos.x / GameData.TileSize, array[i].target_pos.y / GameData.TileSize)
		if (other_target_pos.x == pos.x and other_target_pos.y == pos.y):
			collisions.append(array[i])
	
	return collisions

func environmentObjectAtPos(pos):
	return arrayAtPosForStationary(pos, environmentObjects)

func arrayAtPosForStationary(pos, array):
	var collisions = []
	
	for i in range(array.size()):
		var other_pos = Vector2(array[i].get_position().x / GameData.TileSize, array[i].get_position().y / GameData.TileSize)
		if (other_pos.x == pos.x and other_pos.y == pos.y):
			collisions.append(array[i])
	
	return collisions

func stairsAtPos(pos):
	var envs = arrayAtPosForStationary(pos, environmentObjects)

	for env in envs:
		if "Stairs" in env.get_name():
			return env
	
	return null

func pickedUp(item):
	placedItems.remove(placedItems.find(item))

func itemAtPos(pos):
	for item in placedItems:
		if (item.position.x / 128 == round(pos.x) and item.position.y / 128 == round(pos.y)):
			return item

func itemsAtPos(pos):
	var items = []

	for item in placedItems:
		if (item.position.x / 128 == round(pos.x) and item.position.y / 128 == round(pos.y)):
			items.append(item)
	
	return items

func placeItem(item):
	GameData.placedItems.append(item)
	emit_signal("itemDropped", item)

func isBossLevel(level):
	return (int(level) % bossLevelEvery) == 0

func isFirstBossLevel(level):
	return bossLevelEvery == level
	
func closestEnemy():
	var closestIndex
	var minDistance = -1
	
	for i in range(0, characters.size()):
		if characters[i] != player:
			var distance = player.original_pos.distance_squared_to(characters[i].original_pos)
			
			if minDistance == -1 || distance < minDistance:
				minDistance = distance
				closestIndex = i
	
	if minDistance > -1:
		return characters[closestIndex]
	else:
		return null

func walkable(x, y):
	return tilemap.walkable(x, y)

func check_muted():
	return File.new().file_exists("user://audio_muted.persist")

func reset():
	potions = []
	foods = []
	spells = []
	tilemap = null
	player = null
	environmentObjects = []
	characters = []
	placedItems = []
	current_level = 1
	
	# Erase the saved state
	saved_player = null
	map_seed = null
	#addInitialItemsForTesting()

func getEnemiesWithinAreaAroundPlayer(distance):
	var enemiesInDistance = []
	
	for character in GameData.characters:
		var tileDistance = (character.turn_end_pos - GameData.player.turn_end_pos) / GameData.TileSize
		var xDistance = abs(tileDistance.x)
		var yDistance = abs(tileDistance.y)
		
		if character != GameData.player and xDistance <= distance and yDistance <= distance:
			enemiesInDistance.append(character)
	
	return enemiesInDistance


func string2vec(s):
	var x = s.split(", ")[0].split("(")[1]
	var y = s.split(", ")[1].split(")")[0]
	return Vector2(float(x), float(y))

func dict2item(dict):
	if "subpath" in dict:
		dict["@subpath"] = dict["subpath"]
	var item = dict2inst(dict)
	# Fixes textures not loading
	item.texture = load(item.iconFilePath)
	if "offset" in item:
		# Fixes offset stored as string not Vector2
		item.offset = string2vec(item.offset)
	if "relativeAttackPositions" in item:
		var array = []
		for s in item.relativeAttackPositions:
			array.push_back(string2vec(s))
		item.relativeAttackPositions = array
	return item

func serialise_items(items):
	var dictionaries = []
	for inst in items:
		var dict = inst2dict(inst)
		dictionaries.push_back(dict)
	return dictionaries

func deserialise_items(items):
	var instances = []
	for dict in items:
		instances.push_back(dict2item(dict))
	return instances

func serialise_player(player):
	return {
		"stats": player.stats,
		"primary_weapon": inst2dict(player.primaryWeapon),
		"secondary_weapon": inst2dict(player.secondaryWeapon)
	}

func load_player(dict):
	saved_player = {
		"stats": dict.stats,
		"primaryWeapon": dict2item(dict.primary_weapon),
		"secondaryWeapon": dict2item(dict.secondary_weapon)
	}

func stopSuggestingTutorial():
	if not shouldTutorialHide():
		var hide_tutorial = File.new()
		
		hide_tutorial.open("user://hide-tutorial.save", File.WRITE)
		hide_tutorial.store_line("true")
		
		hide_tutorial.close()

func shouldTutorialHide():
	return File.new().file_exists("user://hide-tutorial.save")

func save_game():
	# TODO: Return the current game state as an object
	var save_game = File.new()
	save_game.open("user://" + chosen_map + ".save", File.WRITE)
	
	save_game.store_line(to_json({
		"level": current_level,
		"seed": map_seed,
		"potions": serialise_items(potions),
		"foods": serialise_items(foods),
		"spells": serialise_items(spells),
		"player": serialise_player(player)
	}))
	save_game.close()

func delete_saved_game():
	var dir = Directory.new()
	dir.remove("user://" + chosen_map + ".save")

func has_save_game(map):
	return File.new().file_exists("user://" + map + ".save")


func load_game():
	# TODO: Load current game state from config object
	var save_game = File.new()
	if not save_game.file_exists("user://" + chosen_map + ".save"):
		return # Error! We don't have a save to load.

	# the object it represents.
	save_game.open("user://" + chosen_map + ".save", File.READ)
	while not save_game.eof_reached():
		var state = parse_json(save_game.get_line())
		if state:
			current_level = state.level
			map_seed = state.seed
			potions = deserialise_items(state.potions)
			foods = deserialise_items(state.foods)
			spells = deserialise_items(state.spells)
			load_player(state.player)
	save_game.close()

func next_level():
	# TODO: Hide HUD node.
	current_level += 1
	for item in placedItems:
		emit_signal("itemPickedUp", item)
		item.queue_free()
	placedItems = []
	for environ in environmentObjects:
		environ.queue_free()
	environmentObjects = []
	for chr in characters:
		if chr != player:
			chr.queue_free()
	characters = [player]
	player.position = Vector2(640, 1024)
	tilemap.next_level()
	save_game()

func toggle_mute():
	muted = not muted
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), muted)
	if muted:
		# Write mute file
		var save_game = File.new()
		save_game.open("user://audio_muted.persist", File.WRITE)
		save_game.store_line(" ")
		save_game.close()
	else:
		# Delete mute file
		var dir = Directory.new()
		dir.remove("user//audio_muted.persist")
