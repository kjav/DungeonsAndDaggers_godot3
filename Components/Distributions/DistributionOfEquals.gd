extends "./Distribution.gd"

func _init(elements).(elements):
	for element in elements:
		element.p = 1/float(elements.size())
		
	._init(elements)