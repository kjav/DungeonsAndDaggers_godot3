extends "TimerBase.gd"

var effectName
var effectDescription
var proportion

func _init():
	colour = Color(1,1,1)

func setProportion(_proportion):
	proportion = _proportion
	
	degrees = 1 * 360
	
	update()

func setEffect(effect):
	get_node("TextureRect").texture = effect.texture