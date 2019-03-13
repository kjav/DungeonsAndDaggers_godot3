tool
extends Node2D

export(String, "Right", "Centre", "Left", "None") var frameStyle setget setFrameStyle, getFrameStyle
export(String, "Potion", "Food", "Spell", "Sword", "Shield", "None") var type setget setType, getType

var leftFrame = preload("res://assets//frame_left.png")
var middleFrame = preload("res://assets//frame_none.png")
var rightFrame = preload("res://assets//frame_right.png")
var potion = preload("res://assets//potion_inventory.png")
var food = preload("res://assets//food_inventory.png")
var spell = preload("res://assets//spell_inventory.png")
var sword = preload("res://assets//basic_sword.png")
var shield = preload("res://assets//basic_shield.png")

func setIconTexture(texture):
	get_node("Icon").set_texture(texture)

func setFrameStyle(style):
	if typeof(style) == TYPE_STRING:
		frameStyle = style
		if frameStyle == "Left":
			get_node("Background").set_texture(leftFrame)
		elif frameStyle == "Centre":
			get_node("Background").set_texture(middleFrame)
		elif frameStyle == "Right":
			get_node("Background").set_texture(rightFrame)

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
