class_name CharacterAttributes
extends Resource

var modifier_buff = 0
var Player_Race: Race
var Player_Skills: Skill

var max_health: int
var CurrentPL: int = 1

var character_speed = 2

enum sizeMods {Psize, meleRange, speed, defense, soak, squares}
enum stat {AG, FO, TE, SC, IN, MA, PE}

#Character Progression Stats
var StatProgression = {
	stat.AG : 1,
	stat.FO : 1,
	stat.TE : 1,
	stat.SC : 1,
	stat.IN : 1,
	stat.MA : 1,
	stat.PE : 1,
}


var SizeModifiers = {
	sizeMods.Psize: "Medium",
	sizeMods.meleRange: 1,
	sizeMods.speed: 0,
	sizeMods.defense: 0,
	sizeMods.soak: 0,
	sizeMods.squares: 1,
}




func _init(char_Race: Race) -> void:
	Player_Race = char_Race

func changeSize(Psize: String, meleRange: int, speed: int, defense: int, soak: int, squares: int):
	SizeModifiers[sizeMods.Psize] = Psize
	SizeModifiers[sizeMods.meleRange] = meleRange
	SizeModifiers[sizeMods.speed] = speed
	SizeModifiers[sizeMods.defense] = defense
	SizeModifiers[sizeMods.soak] = soak
	SizeModifiers[sizeMods.squares] = squares


#increases stat progression
func stat_increase(stat_, ammount):
	StatProgression[stat_] = ammount
	


#Gets the Character's "Score"
func get_score(stat_):
	# _stat is an enum (unsafe)
	var race_mod
	#switch case, faster than if/else
	match stat_:
		stat.AG:
			race_mod = Player_Race.agility
		stat.FO:
			race_mod = Player_Race.force
		stat.TE:
			race_mod = Player_Race.tenacity
		stat.SC:
			race_mod = Player_Race.scholarship
		stat.IN:
			race_mod = Player_Race.insight
		stat.MA:
			race_mod = Player_Race.magic
		stat.PE:
			race_mod = Player_Race.personality
	
	return StatProgression[stat_]+ race_mod

func get_modifier(stat_):
	#transform()
	return get_score(stat_)#+modifier_buff.Transfromation(Name)[stat_]

#func transform():
	#modifier_buff = transformations.new()
	
	
func get_speed(boosted: bool)-> int:
	
	if !boosted:
		character_speed = 2+floor(get_modifier(stat.AG)/2+SizeModifiers[sizeMods.speed])
		if character_speed < 2:
			character_speed = 2
		return character_speed
	else:
		character_speed = 2+floor(get_modifier(stat.AG)+SizeModifiers[sizeMods.speed])
		if character_speed < 2:
			character_speed = 2
		return character_speed


func get_max_health(PowerLvl: int)->int:
	CurrentPL = PowerLvl
	max_health = 60+12*(CurrentPL-1)+(get_score(stat.TE)+Player_Race.health_bonus)*CurrentPL
	return max_health

func get_ToP()->int:
	return floor(CurrentPL/5+1)

	
func get_soak():
	return 



func set_skill_tree(skills: Skill):
	Player_Skills = skills
		
#func add_talent(Talent: TalentMods):
	
#func get_max_ki():

#func get_saving_throw(type):
	#if type == corp:
		#return randf_range(1,10)+get_score(stat.TE)
