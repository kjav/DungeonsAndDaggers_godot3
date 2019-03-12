extends "./DistributionBase.gd"

func _init(elements).(elements):
	pass

func pick():
	var result = []
	for element in elements:
		if randf() <= element.p:
			if is_distribution(element.value):
				result += element.value.pick()
			else:
				result.push_back(element.value)
	return result
