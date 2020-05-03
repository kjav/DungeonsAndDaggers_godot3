extends "TimerBase.gd"

var icon
var effectName
var effectDescription
var proportion

func setProportion(_proportion):
	proportion = _proportion
	update()