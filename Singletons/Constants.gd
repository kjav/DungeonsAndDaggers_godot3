extends Node

# Item Classes
const PotionClasses = preload("res://Items/scripts/Potions.gd")
const FoodClasses = preload("res://Items/scripts/Foods.gd")
const SpellClasses = preload("res://Items/scripts/Spells.gd")
const WeaponClasses = preload("res://Items/scripts/Weapons.gd")
const KeyClasses = preload("res://Items/scripts/Keys.gd")
const UpgradeClasses = preload("res://Items/scripts/Upgrades.gd")

#Distribution Classes
const Set = preload("res://Components/Distributions/Set.gd")
const NumberOf = preload("res://Components/Distributions/NumberOf.gd")
const Distribution = preload("res://Components/Distributions/Distribution.gd")
const IndependentDistribution = preload("res://Components/Distributions/IndependentDistributions.gd")

var UpgradesDistribution = Distribution.new([{
	"p": 0.33, 
	"value": UpgradeClasses.StrengthUpgrade3
}, {
	"p": 0.33, 
	"value": UpgradeClasses.DefenceUpgrade3
}, {
	"p": 0.34, 
	"value": UpgradeClasses.HealthUpgrade1
}])