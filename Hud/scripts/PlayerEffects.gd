extends Node2D

var activeEffects = []
var maxDisplayableEffects = 8

func addEffect(effect, proportion = 1):
	var effectNodeNumber = activeEffects.size() + 1
	
	if effectNodeNumber <= maxDisplayableEffects:
		get_node("Effect" + str(effectNodeNumber)).setEffect(effect)
		get_node("Effect" + str(effectNodeNumber)).setProportion(proportion)
	
	activeEffects.append(effect)

func updateEffectProportion(effect, proportion):
	if proportion <= 0:
		removeActiveEffects(effect)
		return
	
	var nodeIndex = activeEffects.find(effect)
	
	if nodeIndex > -1 && nodeIndex < maxDisplayableEffects:
		get_node("Effect" + str(nodeIndex + 1)).setProportion(proportion)

func removeActiveEffects(effect):
	var nodeIndex = activeEffects.find(effect)
	
	for i in range(nodeIndex, activeEffects.size() - 1):
		activeEffects[i] = activeEffects[i+1]
		
		get_node("Effect" + str(i + 1)).setEffect(activeEffects[i])
		get_node("Effect" + str(i + 1)).setProportion(get_node("Effect" + str(i + 2)).proportion)
	
	if(activeEffects.size() <= maxDisplayableEffects):
		get_node("Effect" + str(activeEffects.size())).hide()
		
	activeEffects.pop_back()