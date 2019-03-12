extends "./DistributionBase.gd"

var n

func _init(element).(repeat(element.value, element.n)):
	self.n = element.n

func repeat(value, number):
	var result = []
	for i in range(0, number):
		result.push_back(value)
	return result

func pick():
	return elements
