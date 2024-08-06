extends CanvasLayer
@onready var Healthbar = $"CharacterInfo/TabContainer/General Info/HealthBarNode/Body/HealthBar"
@onready var TalentsMenu = $CharacterInfo/TabContainer/Talents
@onready var ToPLabel = $"CharacterInfo/TabContainer/General Info/MainInfo/ToPLabel"
@onready var AGModText = $"CharacterInfo/TabContainer/General Info/Modifiers/AGmod"
@onready var FOModText = $"CharacterInfo/TabContainer/General Info/Modifiers/FOmod"
@onready var TEModText = $"CharacterInfo/TabContainer/General Info/Modifiers/TEMod"
@onready var SCModText = $"CharacterInfo/TabContainer/General Info/Modifiers/SCMod"
@onready var INModText = $"CharacterInfo/TabContainer/General Info/Modifiers/INMod"
@onready var MAModText = $"CharacterInfo/TabContainer/General Info/Modifiers/MAMod"
@onready var PEModText = $"CharacterInfo/TabContainer/General Info/Modifiers/PEMod"
@onready var HealthLabel = $"CharacterInfo/TabContainer/General Info/HealthBarNode/HealthLable"
var PowerLevel: int = 1
var character_sheet: CharacterAttributes
var character_race: Race
enum stat {AG, FO, TE, SC, IN, MA, PE}
enum race { 
	SAIYAN, ANDROID, HUMAN, 
	ARCOSIAN, BIOANDROID, CERALIAN, 
	MAJIN, NAMEKIAN, NEOTUFFLE, 
	SHADOWDRAGON,SHINJIN,CUSTOM
	}
var races: Dictionary = {}


func _ready():
	#Preloaded Races
	# race array storing a race class, with its (name, ag, fo, te, sc, in, ma , pe, RaceMod)
	races[race.SAIYAN] = Race.new("Saiyan", 1,2,2,0,0,0,0,3)
	races[race.ANDROID] = Race.new("Android", 0,2,2,0,1,0,0,4)
	races[race.ARCOSIAN] = Race.new("Arcosian", 2,1,2,0,0,0,0,3)
	races[race.NEOTUFFLE] = Race.new("NeoTuffle", 0,0,2,1,2,0,0,4)
	TalentsMenu.TalentLabel.text = "Talents!"
func _on_ag_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.AG, value)
		AGModText.text = "Agility: +"+str(character_sheet.get_modifier(stat.AG))
	

func _on_fo_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.FO, value)
		FOModText.text = "Force: +"+str(character_sheet.get_modifier(stat.FO))

func _on_te_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.TE, value)
		TEModText.text = "Tenacity: +"+str(character_sheet.get_modifier(stat.TE))

func _on_sc_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.SC, value)
		SCModText.text = "Scholarship: +"+str(character_sheet.get_modifier(stat.SC))

func _on_in_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.IN, value)
		INModText.text = "Insight: +"+str(character_sheet.get_modifier(stat.IN))	

func _on_ma_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.MA, value)
		MAModText.text = "Magic: +"+str(character_sheet.get_modifier(stat.MA))

func _on_pe_value_changed(value):
	if character_sheet != null:
		character_sheet.stat_increase(stat.PE, value)
		PEModText.text = "Personality: +"+str(character_sheet.get_modifier(stat.PE))

func _on_race_picker_item_selected(index):
	match index:
		0:
			character_race = races[race.SAIYAN]
			change_character(character_race)
		1:
			character_race = races[race.ANDROID]
			change_character(character_race)
		2:
			character_race = races[race.ARCOSIAN]
			change_character(character_race)
		3:
			character_race = races[race.NEOTUFFLE]
			change_character(character_race)
		
func _on_power_lvl_control_value_changed(value):
	#store PowerLevel to use elsewhere in the script
	PowerLevel = value
	#updates health using current powerlevel
	set_max_health(PowerLevel)
	#shows upgrade menu on powerlevel change
	
	#$UpgradeMenu.show()
	
	#When power level goes up, reset Tier of Power Text
	# and add the tier of power
	ToPLabel.text = "Tier of Power: "
	ToPLabel.text += str(character_sheet.get_ToP())
	

func change_character(char_race: Race):
	if char_race == races[race.SAIYAN]:
		character_sheet = CharacterAttributes.new(char_race)
		set_max_health(PowerLevel)
		set_default_mods()
	if char_race == races[race.ANDROID]:
		character_sheet = CharacterAttributes.new(char_race)
		set_max_health(PowerLevel)
		set_default_mods()
	if char_race == races[race.ARCOSIAN]:
		character_sheet = CharacterAttributes.new(char_race)
		set_max_health(PowerLevel)
		set_default_mods()
	if char_race == races[race.NEOTUFFLE]:
		character_sheet = CharacterAttributes.new(char_race)
		set_max_health(PowerLevel)
		set_default_mods()
		
func set_max_health(lvl):
	if character_sheet != null:
		#sets the healthbar to health using powerlevel
		Healthbar.max_value = character_sheet.get_max_health(lvl)
		# Heals character
		Healthbar.value = Healthbar.max_value
		print(Healthbar.max_value)
		HealthLabel.text = "Health: "+str(Healthbar.value)
		
		
func _on_damage_player_pressed():
	Healthbar.value -= randi_range(1, 10)+3
	if Healthbar.value <= 0:
		get_parent().queue_free()

func set_default_mods():
	AGModText.text = "Agility: +"+str(character_sheet.get_modifier(stat.AG))
	FOModText.text = "Force: +"+str(character_sheet.get_modifier(stat.FO))
	TEModText.text = "Tenacity: +"+str(character_sheet.get_modifier(stat.TE))
	SCModText.text = "Scholarship: +"+str(character_sheet.get_modifier(stat.SC))
	INModText.text = "Insight: +"+str(character_sheet.get_modifier(stat.IN))
	MAModText.text = "Magic: +"+str(character_sheet.get_modifier(stat.MA))
	PEModText.text = "Personality: +"+str(character_sheet.get_modifier(stat.PE))


func _on_base_size_item_selected(index):
	if character_sheet != null:
		match index:
			0:
				#character_sheet.changeSize("Size Name", Melee Range, Speed, Defense Val, Soak Mod, Squares Occ)
				character_sheet.changeSize("Nano", 1, -6, 3, -3, 1)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(1, 1)
			1: 
				character_sheet.changeSize("Tiny", 1, -3, 2, -2, 1)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(1, 1)
			2:
				character_sheet.changeSize("Small", 1, 0, 1, -1, 1)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(1, 1)
			3: #Medium is the base stored value
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(1, 1)
			4: 
				character_sheet.changeSize("Large", 1, 0, -1, 1, 1)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(1, 1)
			5: 
				character_sheet.changeSize("Enormous", 2, 3, -2, 2, 2)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(2, 2)
			6: 
				character_sheet.changeSize("Gigantic", 4, 6, -3, 3, 4)
				get_parent().get_node("PathFollow2D/PlayerSprite").scale = Vector2(4, 4)
		

func _on_more_info_item_selected(index):
	match index:
		0:
			return 0


