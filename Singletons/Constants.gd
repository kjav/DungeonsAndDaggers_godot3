extends Node

# Item Classes
const PotionClasses = {
	"HealthPotion": preload("res://Items/scripts/potions/HealthPotion.gd"),
	"DoubleDamagePotion": preload("res://Items/scripts/potions/DoubleDamagePotion.gd"),
	"InvisibilityPotion": preload("res://Items/scripts/potions/InvisibilityPotion.gd"),
	"LevelUpPotion": preload("res://Items/scripts/potions/LevelUpPotion.gd"),
	"BriefHealthPotion": preload("res://Items/scripts/potions/BriefHealthPotion.gd"),
	"BriefStrengthPotion": preload("res://Items/scripts/potions/BriefStrengthPotion.gd"),
	"BriefDefencePotion": preload("res://Items/scripts/potions/BriefDefencePotion.gd")
}
const FoodClasses = {
	"CookedSteak": preload("res://Items/scripts/foods/CookedSteak.gd"),
	"Apple": preload("res://Items/scripts/foods/Apple.gd"),
	"Cheese": preload("res://Items/scripts/foods/Cheese.gd")
}
const SpellClasses = {
	"EarthquakeSpell": preload("res://Items/scripts/spells/EarthquakeSpell.gd"),
	"FireSpell": preload("res://Items/scripts/spells/FireSpell.gd"),
	"RepelSpell": preload("res://Items/scripts/spells/RepelSpell.gd"),
	"StunSpell": preload("res://Items/scripts/spells/StunSpell.gd"),
	"MissileSpell": preload("res://Items/scripts/spells/MissileSpell.gd"),
	"TeleportSpell": preload("res://Items/scripts/spells/TeleportSpell.gd")
}
const WeaponClasses = {
	"Unarmed": preload("res://Items/scripts/weapons/Unarmed.gd"),
	"CommonSword": preload("res://Items/scripts/weapons/CommonSword.gd"),
	"CommonDagger": preload("res://Items/scripts/weapons/CommonDagger.gd"),
	"CommonShield": preload("res://Items/scripts/weapons/CommonShield.gd"),
	"CommonSpear": preload("res://Items/scripts/weapons/CommonSpear.gd"),
	"CommonBow": preload("res://Items/scripts/weapons/CommonBow.gd"),
	"Bomb": preload("res://Items/scripts/weapons/Bomb.gd"),
	"UncommonSword": preload("res://Items/scripts/weapons/UncommonSword.gd"),
	"UncommonDagger": preload("res://Items/scripts/weapons/UncommonDagger.gd"),
	"UncommonShield": preload("res://Items/scripts/weapons/UncommonShield.gd"),
	"UncommonSpear": preload("res://Items/scripts/weapons/UncommonSpear.gd"),
	"UncommonBow": preload("res://Items/scripts/weapons/UncommonBow.gd"),
	"OgreArm": preload("res://Items/scripts/weapons/OgreArm.gd"),
	"RareSword": preload("res://Items/scripts/weapons/RareSword.gd"),
	"RareDagger": preload("res://Items/scripts/weapons/RareDagger.gd"),
	"RareShield": preload("res://Items/scripts/weapons/RareShield.gd"),
	"RareSpear": preload("res://Items/scripts/weapons/RareSpear.gd"),
	"RareBow": preload("res://Items/scripts/weapons/RareBow.gd")
}
const KeyClasses = {
	"SilverKey": preload("res://Items/scripts/keys/SilverKey.gd")
}
const UpgradeClasses = {
	"StrengthUpgrade3": preload("res://Items/scripts/upgrades/StrengthUpgrade3.gd"),
	"DefenceUpgrade3": preload("res://Items/scripts/upgrades/DefenceUpgrade3.gd"),
	"TrapImmunity": preload("res://Items/scripts/upgrades/TrapImmunity.gd"),
	"QuickSpellcaster": preload("res://Items/scripts/upgrades/QuickSpellcaster.gd"),
	"QuickEater": preload("res://Items/scripts/upgrades/QuickEater.gd"),
	"GreatPalate": preload("res://Items/scripts/upgrades/GreatPalate.gd"),
	"QuickDrinker": preload("res://Items/scripts/upgrades/QuickDrinker.gd"),
	"PotionExtender": preload("res://Items/scripts/upgrades/PotionExtender.gd"),
	"GhostBuster": preload("res://Items/scripts/upgrades/GhostBuster.gd"),
	"MaliciousSpellcaster": preload("res://Items/scripts/upgrades/MaliciousSpellcaster.gd"),
	"HealthUpgrade1": preload("res://Items/scripts/upgrades/HealthUpgrade1.gd")
}

#Distribution Classes
const Set = preload("res://Components/Distributions/Set.gd")
const NumberOf = preload("res://Components/Distributions/NumberOf.gd")
const Distribution = preload("res://Components/Distributions/Distribution.gd")
const DistributionOfEquals = preload("res://Components/Distributions/DistributionOfEquals.gd")
const IndependentDistribution = preload("res://Components/Distributions/IndependentDistributions.gd")

const AllUpgradesUnmodified = [
	{ "value": UpgradeClasses.StrengthUpgrade3, "onetime": false },
	{ "value": UpgradeClasses.DefenceUpgrade3, "onetime": false },
	{ "value": UpgradeClasses.TrapImmunity, "onetime": true },
	{ "value": UpgradeClasses.QuickSpellcaster, "onetime": true },
	{ "value": UpgradeClasses.MaliciousSpellcaster, "onetime": true },
	{ "value": UpgradeClasses.QuickEater, "onetime": true },
	{ "value": UpgradeClasses.GreatPalate, "onetime": true },
	{ "value": UpgradeClasses.QuickDrinker, "onetime": true },
	{ "value": UpgradeClasses.PotionExtender, "onetime": true },
	{ "value": UpgradeClasses.GhostBuster, "onetime": true },
	{ "value": UpgradeClasses.HealthUpgrade1, "onetime": false }
]

var AllUpgrades = AllUpgradesUnmodified

const CommonWeapons = [
	{ "value": WeaponClasses.CommonShield },
	{ "value": WeaponClasses.CommonSword },
	{ "value": WeaponClasses.CommonDagger },
	{ "value": WeaponClasses.CommonSpear },
	{ "value": WeaponClasses.CommonBow }
]

const UncommonWeapons = [
	{ "value": WeaponClasses.Bomb },
	{ "value": WeaponClasses.UncommonSpear },
	{ "value": WeaponClasses.UncommonSword },
	{ "value": WeaponClasses.UncommonDagger },
	{ "value": WeaponClasses.UncommonShield },
	{ "value": WeaponClasses.UncommonBow }
]

const RareWeapons = [
	{ "value": WeaponClasses.RareSpear },
	{ "value": WeaponClasses.RareSword },
	{ "value": WeaponClasses.RareDagger },
	{ "value": WeaponClasses.RareShield },
	{ "value": WeaponClasses.RareBow }
]

const CommonPotions = [
	{ "value": PotionClasses.BriefHealthPotion },
	{ "value": PotionClasses.BriefStrengthPotion },
	{ "value": PotionClasses.BriefDefencePotion }
]

const UncommonPotions = [
	{ "value": PotionClasses.DoubleDamagePotion },
	{ "value": PotionClasses.InvisibilityPotion }
]

const RarePotions = [
	{ "value": PotionClasses.HealthPotion },
	{ "value": PotionClasses.LevelUpPotion }
]

const CommonSpells = [
	{ "value": SpellClasses.TeleportSpell },
	{ "value": SpellClasses.MissileSpell },
	{ "value": SpellClasses.StunSpell }
]

const UncommonSpells = [
	{ "value": SpellClasses.EarthquakeSpell },
	{ "value": SpellClasses.RepelSpell }
]

const RareSpells = [
	{ "value": SpellClasses.FireSpell }
]

const CommonFoods = [
	{ "value": FoodClasses.Apple }
]

const UncommonFoods = [
	{ "value": FoodClasses.Cheese }
]

const RareFoods = [
	{ "value": FoodClasses.CookedSteak }
]

var AllCommonItemsDistribution = DistributionOfEquals.new(CommonFoods + CommonPotions + CommonSpells + CommonWeapons)
var AllUncommonItemsDistribution = DistributionOfEquals.new(UncommonFoods + UncommonPotions + UncommonSpells + UncommonWeapons)
var AllRareItemsDistribution = DistributionOfEquals.new(RareFoods + RarePotions + RareSpells + RareWeapons)

var AllCommonPotionsSpellsDistribution = DistributionOfEquals.new(CommonPotions + CommonSpells)
var AllUncommonPotionsSpellsDistribution = DistributionOfEquals.new(UncommonPotions + UncommonSpells)
var AllRarePotionsSpellsDistribution = DistributionOfEquals.new(RarePotions + RareSpells)

var CommonWeaponsDistribution = DistributionOfEquals.new(CommonWeapons)
var CommonPotionsDistribution = DistributionOfEquals.new(CommonPotions)
var CommonSpellsDistribution = DistributionOfEquals.new(CommonSpells)
var CommonFoodsDistribution = DistributionOfEquals.new(CommonFoods)

var UncommonWeaponsDistribution = DistributionOfEquals.new(UncommonWeapons)
var UncommonPotionsDistribution = DistributionOfEquals.new(UncommonPotions)
var UncommonSpellsDistribution = DistributionOfEquals.new(UncommonSpells)
var UncommonFoodsDistribution = DistributionOfEquals.new(UncommonFoods)

var RareWeaponsDistribution = DistributionOfEquals.new(RareWeapons)
var RarePotionsDistribution = DistributionOfEquals.new(RarePotions)
var RareSpellsDistribution = DistributionOfEquals.new(RareSpells)
var RareFoodsDistribution = DistributionOfEquals.new(RareFoods)

var UpgradesDistribution = DistributionOfEquals.new(AllUpgrades)