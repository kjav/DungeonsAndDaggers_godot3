var elements

func _init(elements):
	self.elements = elements

func pick():
	pass

func is_distribution(d):
	if typeof(d) == 18 and d.is_type("Distribution"):
		return true

func get_type():
	return "Distribution"

func is_type(type):
	return type == "Distribution" or .is_type(type)
