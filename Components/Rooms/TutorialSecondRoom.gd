extends 'RoomBase.gd'

func _init():
	symmetry = SYMMETRY.none

func setup_params():
	extents_distribution = Set.new([Vector2(5, 11)])
	npc_distribution =  IndependentDistribution.new(
	[
		{
			"p": 1, 
			"value": load("res://Characters/WaterSpirit.tscn"),
			"position": Vector2(2, 3)
		},
		{
			"p": 1, 
			"value": load("res://Characters/FireSpirit.tscn"),
			"position": Vector2(2, 4)
		},
		{
			"p": 1, 
			"value": load("res://Characters/WaterSpirit.tscn"),
			"position": Vector2(2, 6)
		},
		{
			"p": 1, 
			"value": load("res://Characters/FireSpirit.tscn"),
			"position": Vector2(2, 7)
		}
	])
	environment_distribution = IndependentDistribution.new([
		{
			"p": 1,
			"value": load("res://Environments/LevelStairs.tscn"),
			"position": Vector2(1, 1)
		},
		{
			"p": 1,
			"value": load("res://Environments/UpgradeStand.tscn"),
			"position": Vector2(2, 2)
		}])
	item_distribution = IndependentDistribution.new([
		{
			"p": 1, 
			"value": Constants.SpellClasses.EarthquakeSpell,
			"position": Vector2(3, 6)
		},
		{
			"p": 1, 
			"value": Constants.PotionClasses.BriefStrengthPotion,
			"position": Vector2(3, 1)
		},
	])
