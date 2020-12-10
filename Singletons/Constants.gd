extends Node

var TileResource = load("res://assets/tilesets/OldCastleTileset.res")

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
	"CommonStaff": preload("res://Items/scripts/weapons/CommonStaff.gd"),
	"Bomb": preload("res://Items/scripts/weapons/Bomb.gd"),
	"UncommonSword": preload("res://Items/scripts/weapons/UncommonSword.gd"),
	"UncommonDagger": preload("res://Items/scripts/weapons/UncommonDagger.gd"),
	"UncommonShield": preload("res://Items/scripts/weapons/UncommonShield.gd"),
	"UncommonSpear": preload("res://Items/scripts/weapons/UncommonSpear.gd"),
	"UncommonBow": preload("res://Items/scripts/weapons/UncommonBow.gd"),
	"UncommonStaff": preload("res://Items/scripts/weapons/UncommonStaff.gd"),
	"RareSword": preload("res://Items/scripts/weapons/RareSword.gd"),
	"RareDagger": preload("res://Items/scripts/weapons/RareDagger.gd"),
	"RareShield": preload("res://Items/scripts/weapons/RareShield.gd"),
	"RareSpear": preload("res://Items/scripts/weapons/RareSpear.gd"),
	"RareBow": preload("res://Items/scripts/weapons/RareBow.gd"),
	"RareStaff": preload("res://Items/scripts/weapons/RareStaff.gd")
}

const KeyClasses = {
	"SilverKey": preload("res://Items/scripts/keys/SilverKey.gd")
}

const Enemies = {
	"Raven": preload("res://Characters/Raven.tscn"),
	"Mummy": preload("res://Characters/Mummy.tscn"),
	"Necromancer": preload("res://Characters/Necromancer.tscn"),
	"Reaper": preload("res://Characters/Reaper.tscn"),
	"TrainingDummy": preload("res://Characters/TrainingDummy.tscn"),
	"UndeadDragon": preload("res://Characters/UndeadDragon.tscn"),
	"ZombieBrown": preload("res://Characters/ZombieBrown.tscn"),
	"ZombieCreme": preload("res://Characters/ZombieCreme.tscn"),
}

const Environments = {
	"CommonChest": preload("res://Environments/CommonChest.tscn"),
	"UncommonChest": preload("res://Environments/UncommonChest.tscn"),
	"RareChest": preload("res://Environments/RareChest.tscn"),
}

const UpgradeClasses = {
	"StrengthUpgrade": preload("res://Items/scripts/upgrades/StrengthUpgrade.gd"),
	"DefenceUpgrade": preload("res://Items/scripts/upgrades/DefenceUpgrade.gd"),
	"TrapImmunity": preload("res://Items/scripts/upgrades/TrapImmunity.gd"),
	"QuickSpellcaster": preload("res://Items/scripts/upgrades/QuickSpellcaster.gd"),
	"QuickEater": preload("res://Items/scripts/upgrades/QuickEater.gd"),
	"GreatPalate": preload("res://Items/scripts/upgrades/GreatPalate.gd"),
	"ReserveWeapon": preload("res://Items/scripts/upgrades/ReserveWeapon.gd"),
	"QuickDrinker": preload("res://Items/scripts/upgrades/QuickDrinker.gd"),
	"PotionExtender": preload("res://Items/scripts/upgrades/PotionExtender.gd"),
	"ReaperRoom": preload("res://Items/scripts/upgrades/ReaperBuster.gd"),
	"Versatile": preload("res://Items/scripts/upgrades/Versatile.gd"),
	"MaliciousSpellcaster": preload("res://Items/scripts/upgrades/MaliciousSpellcaster.gd"),
	"HealthUpgrade1": preload("res://Items/scripts/upgrades/HealthUpgrade1.gd")
}

var StatusEffects = {
	"IncreasedDefence": preload("res://StatusEffects/IncreasedDefence.gd").new(),
	"IncreasedStrength": preload("res://StatusEffects/IncreasedStrength.gd").new(),
	"TemporaryHealth": preload("res://StatusEffects/TemporaryHealth.gd").new(),
	"Invisible": preload("res://StatusEffects/Invisible.gd").new(),
	"DoubleDamage": preload("res://StatusEffects/DoubleDamage.gd").new(),
	"ReaperBuster": preload("res://StatusEffects/ReaperBuster.gd").new(),
	"SophisticatedPalate": preload("res://StatusEffects/SophisticatedPalate.gd").new(),
	"MaliciousSpellcasting": preload("res://StatusEffects/MaliciousSpellcasting.gd").new(),
	"ExtendedBriefPotions": preload("res://StatusEffects/ExtendedBriefPotions.gd").new(),
	"QuickDrinking": preload("res://StatusEffects/QuickDrinking.gd").new(),
	"QuickEating": preload("res://StatusEffects/QuickEating.gd").new(),
	"QuickSpellcasting": preload("res://StatusEffects/QuickSpellcasting.gd").new(),
	"TrapImmune": preload("res://StatusEffects/TrapImmune.gd").new(),
}

#Distribution Classes
const Set = preload("res://Components/Distributions/Set.gd")
const NumberOf = preload("res://Components/Distributions/NumberOf.gd")
const Distribution = preload("res://Components/Distributions/Distribution.gd")
const DistributionOfEquals = preload("res://Components/Distributions/DistributionOfEquals.gd")
const IndependentDistribution = preload("res://Components/Distributions/IndependentDistributions.gd")

const AppStoreMicrotransactions = { 
	"AdFree": "ad_free"
}

const AllUpgradesUnmodified = [
	{ "value": UpgradeClasses.StrengthUpgrade, "onetime": false },
	{ "value": UpgradeClasses.DefenceUpgrade, "onetime": false },
	{ "value": UpgradeClasses.TrapImmunity, "onetime": true },
	{ "value": UpgradeClasses.QuickSpellcaster, "onetime": true },
	{ "value": UpgradeClasses.MaliciousSpellcaster, "onetime": true },
	{ "value": UpgradeClasses.QuickEater, "onetime": true },
	{ "value": UpgradeClasses.GreatPalate, "onetime": true },
	{ "value": UpgradeClasses.QuickDrinker, "onetime": true },
	{ "value": UpgradeClasses.PotionExtender, "onetime": true },
	{ "value": UpgradeClasses.ReaperRoom, "onetime": true },
	{ "value": UpgradeClasses.Versatile, "onetime": true },
	{ "value": UpgradeClasses.ReserveWeapon, "onetime": true },
	{ "value": UpgradeClasses.HealthUpgrade1, "onetime": false }
]

var AllUpgrades = AllUpgradesUnmodified

const CommonWeapons = [
	{ "value": WeaponClasses.CommonShield },
	{ "value": WeaponClasses.CommonSword },
	{ "value": WeaponClasses.CommonDagger },
	{ "value": WeaponClasses.CommonSpear },
	{ "value": WeaponClasses.CommonBow },
	{ "value": WeaponClasses.CommonStaff }
]

const UncommonWeapons = [
	{ "value": WeaponClasses.Bomb },
	{ "value": WeaponClasses.UncommonSpear },
	{ "value": WeaponClasses.UncommonSword },
	{ "value": WeaponClasses.UncommonDagger },
	{ "value": WeaponClasses.UncommonShield },
	{ "value": WeaponClasses.UncommonBow },
	{ "value": WeaponClasses.UncommonStaff }
]

const RareWeapons = [
	{ "value": WeaponClasses.RareSpear },
	{ "value": WeaponClasses.RareSword },
	{ "value": WeaponClasses.RareDagger },
	{ "value": WeaponClasses.RareShield },
	{ "value": WeaponClasses.RareBow },
	{ "value": WeaponClasses.RareStaff }
]

const CommonPotions = [
	{ "value": PotionClasses.BriefHealthPotion },
	{ "value": PotionClasses.BriefStrengthPotion },
	{ "value": PotionClasses.BriefDefencePotion }
]

const UncommonPotions = [
	{ "value": PotionClasses.DoubleDamagePotion },
	{ "value": PotionClasses.InvisibilityPotion },
	{ "value": PotionClasses.HealthPotion },
]

const RarePotions = [
	{ "value": PotionClasses.LevelUpPotion },
]

const CommonSpells = [
	{ "value": SpellClasses.MissileSpell },
	{ "value": SpellClasses.StunSpell },
	{ "value": SpellClasses.TeleportSpell },
]

const UncommonSpells = [
	{ "value": SpellClasses.EarthquakeSpell },
	{ "value": SpellClasses.RepelSpell },
]

const RareSpells = [
	{ "value": SpellClasses.FireSpell },
]

const CommonFoods = [
	{ "value": FoodClasses.Apple },
]

const UncommonFoods = [
	{ "value": FoodClasses.Cheese },
]

const RareFoods = [
	{ "value": FoodClasses.CookedSteak },
]

const NonBossEnemies = [
	{ "value": Enemies.Raven },
	{ "value": Enemies.Mummy },
	{ "value": Enemies.Necromancer },
	{ "value": Enemies.Reaper },
	{ "value": Enemies.ZombieBrown },
	{ "value": Enemies.ZombieCreme }
]

const BossEnemies = [
	{ "value": Enemies.UndeadDragon }
]

const Chests = [
	{ "value": Environments.CommonChest },
	{ "value": Environments.UncommonChest },
	{ "value": Environments.RareChest }
]

var AllChestsDistribution = DistributionOfEquals.new(Chests)

var AllCommonItemsDistribution = DistributionOfEquals.new(CommonFoods + CommonPotions + CommonSpells + CommonWeapons)
var AllUncommonItemsDistribution = DistributionOfEquals.new(UncommonFoods + UncommonPotions + UncommonSpells + UncommonWeapons)
var AllRareItemsDistribution = DistributionOfEquals.new(RareFoods + RarePotions + RareSpells + RareWeapons)
var AllItemsDistribution = DistributionOfEquals.new(CommonFoods + CommonPotions + CommonSpells + CommonWeapons + UncommonFoods + UncommonPotions + UncommonSpells + UncommonWeapons + RareFoods + RarePotions + RareSpells + RareWeapons)

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
var AllHarmfulEnemies = DistributionOfEquals.new(NonBossEnemies + BossEnemies)
