var Set = Constants.Set
var NumberOf = Constants.NumberOf
var Distribution = Constants.Distribution
var DistributionOfEquals = Constants.DistributionOfEquals
var IndependentDistribution = Constants.IndependentDistribution

var doorClass = preload("res://Environments/Door.tscn")

var environment_distribution
var item_distribution
var npc_distribution
var extents_distribution
var isBossRoom
var oneEntrance

# Specifies the mirror axis that this room is symmetrical on
enum SYMMETRY {
	all,
	none
}
var symmetry = SYMMETRY.all

func setup_params():
	pass

func _init():
	setup_params()

func apply_randomness():
	pass

func rotate(extents):
	if symmetry == SYMMETRY.none:
		return extents
	elif symmetry == SYMMETRY.all:
		if randf() > 0.5:
			return extents
		else:
			# Multiply by rotated (1, 1) to ensure positive extents
			return (extents.rotated(PI / 2) * Vector2(1, 1).rotated(PI / 2)).snapped(Vector2(1, 1))
	# The symmetry setting isn't in the enum
	print("Invalid symmetry setting")
	return extents

func getSpawnDistributions():
	# Pick from the spawn distributions
	var extendsRotated = rotate(extents_distribution.pick()[0]) if (extents_distribution != null) else []
	var environments = environment_distribution.pick() if (environment_distribution != null) else []
	
	environments += rugsInRoom(extendsRotated, environments)
	environments += wallEnvironmentsInRoom(extendsRotated, environments)
	
	return {
		"extents": extendsRotated,
		"environments": environments,
		"items": item_distribution.pick() if (item_distribution != null) else [],
		"npcs": npc_distribution.pick() if (npc_distribution != null) else []
	}

func rugsInRoom(var extendsRotated, var environments):
	if randi()%2 == 0:
		var rugArray = []
		var rugColumn = randi()%int(extendsRotated.x-2)+1
		
		for y in range(1, extendsRotated.y-1):
			rugArray.append({
				"p": 1, 
				"value": load("res://Environments/Rug.tscn"),
				"position": Vector2(rugColumn, y)
			})
		
		var rug_distribution = IndependentDistribution.new(rugArray)
		
		return rug_distribution.pick()
	
	return []

func wallEnvironmentsInRoom(var extendsRotated, var environments):
	if randi()%2 == 0:
		var windowColumn = randi()%int(extendsRotated.x-2)+1
		var wallEnvironmentsDistributions = DistributionOfEquals.new([{
			"value": load("res://Environments/Window.tscn"),
			"position": Vector2(windowColumn, 0)
		}, {
			"value": load("res://Environments/Alcove.tscn"),
			"position": Vector2(windowColumn, 0)
		}, {
			"value": load("res://Environments/Flag.tscn"),
			"position": Vector2(windowColumn, 0)
		}])
		
		return wallEnvironmentsDistributions.pick()
	
	return []
