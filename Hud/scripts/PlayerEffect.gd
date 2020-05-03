extends "TimerBase.gd"

var effect
var effectName
var effectDescription
var proportion

func _init():
	colour = Color(1,1,1)

func setProportion(_proportion):
	proportion = _proportion
	
	degrees = proportion * 360
	
	update()

func setEffect(_effect):
	effect = _effect
	effectName = effect.effectName
	effectDescription = effect.effectDescription
	get_node("TextureRect").set_texture(_effect.texture)
	
	visible = true