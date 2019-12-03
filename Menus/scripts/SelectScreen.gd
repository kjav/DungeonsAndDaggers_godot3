extends Node2D

export var active = true

signal changed(index)

var items
var current_item = 0

var right_arrow
var left_arrow

func _ready():
	items = self.get_parent().get_items()
	left_arrow = get_node("LeftArrow")
	right_arrow = get_node("RightArrow")
	
	var selectedStart = 0
	
	if(GameData.shouldTutorialHide()):
		selectedStart = 1
	
	if items.size() > 0:
		select_item(selectedStart)

func left():
	if active and current_item > 0:
		select_item(current_item - 1)

func right():
	if active and current_item < items.size() - 1:
		select_item(current_item + 1)

func select_item(item):
	current_item = item
	
	hideAllButCurrent()
	
	DisableUnusableArrows()
	
	emit_signal("changed", current_item)

func hideAllButCurrent():
	for i in range(items.size()):
		items[i].hide()
	
	items[current_item].set_position(Vector2(540, 550))
	items[current_item].show()

func DisableUnusableArrows():
	var leftArrowOpacity = 1
	var rightArrowOpacity = 1
	
	if current_item == 0:
		leftArrowOpacity = 0.2
	
	if current_item == items.size() - 1:
		rightArrowOpacity = 0.2
	
	left_arrow.modulate.a = leftArrowOpacity
	right_arrow.modulate.a = rightArrowOpacity

func selected_item():
	return items[current_item]
