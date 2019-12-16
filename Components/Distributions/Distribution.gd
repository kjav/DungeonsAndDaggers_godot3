extends "./DistributionBase.gd"

var cumulative_elements

func _init(elements).(elements):
	cumulative_elements = []
	var p_sum = 0
	for element in elements:
		if element.has("p"):
			#Be careful changing cumulative_element as duplicate is not a deep copy, changing any object will also change it on element.	
			var cumulative_element = element.duplicate()
			cumulative_element.p = p_sum
			
			cumulative_elements.push_back(cumulative_element)
			p_sum = p_sum + element.p
	if p_sum > 1:
		# Divide all probabilities by their sums to get values summing to 1.
		for element in cumulative_elements:
			if element.has("p"):
				element.p = element.p / p_sum
	elif p_sum < 1:
		# Add a null element to be picked for the rest of the [0, 1] probability range.
		cumulative_elements.push_back({ "p": p_sum })

func pick():
	var HIGH_INDEX = cumulative_elements.size() - 1
	var LOW_INDEX = 0
	var p = randf()
	var element
	
	while HIGH_INDEX > LOW_INDEX + 1:
		var INDEX = floor((HIGH_INDEX - LOW_INDEX) / 2.0) + 1
		element = cumulative_elements[INDEX]
		if element.p < p:
			LOW_INDEX = INDEX
		elif element.p > p:
			HIGH_INDEX = INDEX - 1
	if cumulative_elements[HIGH_INDEX].p < p:
		LOW_INDEX = HIGH_INDEX
	element = cumulative_elements[LOW_INDEX]
		
	if !element.has("value"):
		return []
	elif is_distribution(element.value):
		return element.value.pick()
	else:
		return [element]
