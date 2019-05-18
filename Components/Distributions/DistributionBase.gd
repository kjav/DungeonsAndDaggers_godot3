var elements

func _init(elements):
	self.elements = elements

func pick():
	pass

func is_distribution(distribution):
	if typeof(distribution) == TYPE_DICTIONARY:
		return true

func get_type():
	return "Distribution"

func is_type(type):
	return type == "Distribution" or .is_type(type)
