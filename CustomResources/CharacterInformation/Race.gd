class_name Race
extends Resource

var race: String
#Race Modifiers
var agility = 0
var force = 0
var tenacity = 0
var scholarship = 0
var insight = 0
var magic = 0
var personality = 0
var health_bonus

#The Word function creates the race modifiers and feeds them into the class
# then the class is given to the players or NPCS we want
func _init(race_name: String, AG, FO, TE, SC, IN, MA, PE, Life_mod):
	race = race_name
	agility = AG
	force = FO
	tenacity = TE
	scholarship = SC
	insight = IN
	magic = MA
	personality = PE
	health_bonus = Life_mod

