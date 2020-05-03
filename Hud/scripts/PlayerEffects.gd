extends Node2D

func addEffect(effect, proportion = 1):
	get_node("Effect1").setEffect(effect)
	get_node("Effect1").setProportion(proportion)

func updateEffectProportion(effect, proportion):
	get_node("Effect1").setProportion(proportion)