tool
extends Node2D

export(int) var maxProgress setget setMaxProgress, getMaxProgress
export(int) var progress setget setProgress, getProgress
export(String) var range_name setget setName, getName
export(bool) var editable setget setEditable, getEditable

var off_texture = preload("res://assets/range_tile_off.png")
var on_texture = preload("res://assets/range_tile_on.png")
var minus_button
var plus_button
var value_label
var name_label
var blocks = []

func getMinusButton():
	if !minus_button:
		minus_button = self.get_node("RangeMinusButton")
	return minus_button

func getPlusButton():
	if !plus_button:
		plus_button = self.get_node("RangePlusButton")
	return plus_button

func getValueLabel():
	if !value_label:
		value_label = self.get_node("RangeValueLabel")
	return value_label

func getNameLabel():
	if !name_label:
		name_label = self.get_node("RangeNameLabel")
	return name_label

func setupBlocks():
	if (typeof(maxProgress) == typeof(0)) and (typeof(progress) == typeof(0)):
		# Set position of node to center it
		var width = maxProgress * 30 + 90
		var button_size = 120
		# Set position of plus button
		getPlusButton().set_position(Vector2(width / 2 - (button_size - 40), -60))
		# Set position of minus button
		getMinusButton().set_position(Vector2(-width / 2 - (button_size - 80), -60))
		# Set position of value label
		getValueLabel().set_position(Vector2(width / 2 + 10, -21))
		# Set position of name label
		getNameLabel().set_position(Vector2(-width / 2 - 290, -21))
		for i in range(blocks.size()):
			blocks[i].modulate.a = 0
			blocks[i].free()
		blocks = []
		for i in range(maxProgress):
			var new_block = TextureRect.new()
			self.add_child(new_block)
			new_block.set_owner(self)
			new_block.set_position(Vector2(-width / 2 + i * 30 + 50, -20))
			blocks.push_back(new_block)
		
		for i in range(blocks.size()):
			if i < progress:
				blocks[i].set_texture(on_texture)
			else:
				blocks[i].set_texture(off_texture)

func setMaxProgress(value):
	maxProgress = value
	setupBlocks()

func getMaxProgress():
	return maxProgress

func setProgress(value):
	if typeof(value) == TYPE_INT and value >= 0 and value <= maxProgress:
		progress = value
		getValueLabel().text = str(value)
		setupBlocks()

func getProgress():
	return progress

func getName():
	return name;

func setName(value):
	if typeof(value) == TYPE_STRING:
		getNameLabel().text = str(value)
		name = value

func setEditable(value):
	if typeof(value) == TYPE_BOOL:
		editable = value
		get_node("RangePlusButton").set_disabled(!value)
		get_node("RangeMinusButton").set_disabled(!value)

func getEditable():
	return editable
