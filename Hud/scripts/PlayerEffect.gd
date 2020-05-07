extends "TimerBase.gd"

var effect
var effectName
var effectDescription
var proportion

func _init():
	colour = Color(0.5,0.7,0.5)

func setProportion(_proportion):
	proportion = _proportion
	
	degrees = proportion * 360
	
	update()

func setEffect(_effect):
	effect = _effect
	effectName = effect.effectName
	effectDescription = effect.effectDescription
	
	get_node("margin/TextureRect").set_texture(_effect.texture)
	get_node("margin/TextureRect").set_scale(Vector2(1,1)/(_effect.texture.get_size()/Vector2(340,340)))
	
	visible = true