var Set = Constants.Set
var NumberOf = Constants.NumberOf
var Distribution = Constants.Distribution
var IndependentDistribution = Constants.IndependentDistribution

var environment_distribution
var item_distribution
var npc_distribution
var extents_distribution

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

func get():
	# Pick from the spawn distributions
	return {
		"extents": rotate(extents_distribution.pick()[0]),
		"environments": environment_distribution.pick(),
		"items": item_distribution.pick(),
		"npcs": npc_distribution.pick()
	}
