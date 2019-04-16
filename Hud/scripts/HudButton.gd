tool
extends Node2D

export(String, "Pink", "Blue", "Green", "Yellow", "Orange", "None") var frameStyle setget setFrameStyle, getFrameStyle
export(String, "Potion", "Food", "Spell", "Sword", "Shield", "None") var type setget setType, getType

var pink = preload("res://assets//ring_inner_pink.png")
var blue = preload("res://assets//ring_inner_blue.png")
var green = preload("res://assets//ring_inner_green.png")
var yellow = preload("res://assets//ring_inner_yellow.png")
var orange = preload("res://assets//ring_inner_orange.png")
var potion = preload("res://assets//ring_potion_inventory.png")
var food = preload("res://assets//ring_food_inventory.png")
var spell = preload("res://assets//ring_spell_inventory.png")
var sword = preload("res://assets//basic_sword.png")
var shield = preload("res://assets//basic_shield.png")

func setIconTexture(texture):
	get_node("Icon").set_texture(texture)

func setFrameStyle(style):
	if typeof(style) == TYPE_STRING:
		frameStyle = style
		if frameStyle == "Pink":
			get_node("Background").set_texture(pink)
		elif frameStyle == "Orange":
			get_node("Background").set_texture(orange)
		elif frameStyle == "Blue":
			get_node("Background").set_texture(blue)
		elif frameStyle == "Yellow":
			get_node("Background").set_texture(yellow)
		elif frameStyle == "Green":
			get_node("Background").set_texture(green)

func getFrameStyle():
	return frameStyle
	
func getType():
	return type

func setType(newType):
	if typeof(newType) == TYPE_STRING:
		type = newType
		if type == "Potion":
			get_node("Icon").set_texture(potion)
		elif type == "Food":
			get_node("Icon").set_texture(food)
		elif type == "Spell":
			get_node("Icon").set_texture(spell)
		elif type == "Sword":
			get_node("Icon").set_texture(sword)
		elif type == "Shield":
			get_node("Icon").set_texture(shield)
