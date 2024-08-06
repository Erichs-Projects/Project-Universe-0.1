extends Node2D



# Astar creation
@onready var astar_grid: AStarGrid2D = AStarGrid2D.new()
@export var game_map: TileMap 
#Tilemap resources that helps the other nodes know where the tilemap blocks are
@export var tilemap_info:= Resource

@onready var ActionMenu = $Ui

var selected_unit
var can_walk: bool = true
var selection_index = 0
var unit_positions: Array = []
var unit_nodes: Array = []
var is_highlighted: bool = false
var draw_astar = false
var walkable_tiles: Array = []
var use_boosted_s = false

#stores our enum race as a dictionary of races, using our race resource
var races: Dictionary = {}
var give_race #stores a race to give a unit/npc
enum race { 
	SAIYAN, ANDROID, HUMAN, 
	ARCOSIAN, BIOANDROID, CERALIAN, 
	MAJIN, NAMEKIAN, NEOTUFFLE, 
	SHADOWDRAGON,SHINJIN,CUSTOM
	}
enum stat {AG, FO, TE, SC, IN, MA, PE}

func _ready():
	astar_grid.region = game_map.get_used_rect() # sets the size of the grid it can map to to the size of the tilemap
	astar_grid.cell_size = Vector2i(32, 32) # cell size of the grid
	astar_grid.set_diagonal_mode(astar_grid.DIAGONAL_MODE_ONLY_IF_NO_OBSTACLES) #makes it so the Astar region doesnt map diagonally
	astar_grid.update() # updates all these parameters into the astar grid
	
	#races[race.SAIYAN] = Race.new("Saiyan", 1,2,2,0,0,0,0,3)
	#races[race.ANDROID] = Race.new("Android", 0,2,2,0,1,0,0,4)
	#give_race = races[race.SAIYAN]
	
	#connects the walked_finished from player to level node, and calls
	#our function _on_character_walked_finished, when 'walked_finished' is emitted from player
	#stores unit starting positions in our level, and their respective nodes for easy access/changes
	unit_nodes = $"Turn Manager/TurnQueue".get_children()
	for unit in get_tree().get_nodes_in_group('Characters'):
		unit_positions.append(game_map.local_to_map(unit.global_position))
		
		unit.connect('walked_finished', _on_character_walked_finished)
		
	#$Player1.Char_race = give_race
	#$Player1.create_npc()
	#print("Saiyan Agility Score: ", $Player1.Character.get_score(stat.AG))
	#print("Saiyan Speed: ", $Player1.Character.get_speed(false))
	#$Player2.Char_race = races[race.ANDROID]
	#$Player2.create_npc()
	#print("Android Agility: ", $Player2.Character.get_score(stat.AG))
	#print("Android Speed: ", $Player2.Character.get_speed(false))
	

	
func _input(event):
	if event.is_action_pressed('escape'):
		ActionMenu.visible = !ActionMenu.visible
	if event.is_action_pressed('primary_action'):
		#if the player clicks
		var current_mos = game_map.local_to_map(get_global_mouse_position())
		#get the mouse position coordinates
		if current_mos in unit_positions and is_highlighted == false:
			#see if the walk range is highlighted and if the coordinates of the mouse is in the list of
			#positions the units are in
			for unit in range(unit_positions.size()):
				#loops over the units to find which unit the mouse position is over
				if current_mos == unit_positions[unit]:
					selection_index = unit
					if selected_unit != null:
						#makes sure previous unit is unselected
						selected_unit.is_selected = false
						ActionMenu.charactersheetbutton.button_pressed = false
						remove_highlights()
					#selects (new) unit you pick on	
					selected_unit = unit_nodes[selection_index]	
					ActionMenu.charactersheetbutton.button_pressed = true
					break
			print(selected_unit)
			selected_unit.is_selected = !selected_unit.is_selected
			
	
	if event.is_action_pressed('secondary_action'):
		print(unit_nodes)
		print(unit_positions)
		
		
	if event.is_action_pressed('primary_action') and is_highlighted and can_walk and draw_astar and game_map.local_to_map(get_global_mouse_position()) != game_map.local_to_map(selected_unit.global_position):
	
		var movement_path = astar_grid.get_id_path(game_map.local_to_map(selected_unit.global_position), game_map.local_to_map(get_global_mouse_position()))
		
		selected_unit.move_character(movement_path)
		
		#makes sure the player cannot move the character to a new path while its traveling
		can_walk = false


func _on_ui_movement_on():
	if selected_unit != null:	
		if is_highlighted == false and can_walk:
			highlight_range_tiles()
		else:
			remove_highlights()

	
func _on_character_walked_finished():
	can_walk = true
	remove_highlights()
	unit_positions[selection_index] = game_map.local_to_map(selected_unit.global_position)
	#replaces the stored location of the unit so the game knows where its new position is
	print("added ", game_map.local_to_map(selected_unit.global_position))

func highlight_range_tiles():
	is_highlighted = true
	if selected_unit.Sheet.character_sheet != null:
		var UnitSheet = selected_unit.Sheet.character_sheet
		var movement_range = UnitSheet.get_speed(use_boosted_s)  #character's walk range
		var attack_range = movement_range + 1
		var character_position = game_map.local_to_map(selected_unit.global_position)
		
		highlight_walkable_range(character_position, movement_range)
		#movement box
		
		highlight_attack_range(character_position, attack_range)
		#attack box

func highlight_walkable_range(character, movement_range):
	#creates a square of players walkable tiles based on their movement range
	# the plus 1 to movement range makes up for the tile the character is standing on
	for x in range(character.x - movement_range, character.x + movement_range +1 ):
		for y in range(character.y - movement_range, character.y + movement_range +1 ):
			walkable_tiles.append(Vector2i(x,y))
			game_map.set_cell(2, Vector2i(x, y), 5, Vector2i(0, 0), 0)

func highlight_attack_range(character, attack_range):
	
	for x in range(character.x - attack_range, character.x + attack_range + 1):
		for y in range(character.y - attack_range, character.y + attack_range + 1):
				game_map.set_cell(1, Vector2i(x, y), 1, Vector2i(0,0), 0)
				
	for x in range(character.x - attack_range+1, character.x + attack_range):
		for y in range(character.y - attack_range+1, character.y + attack_range):
				game_map.erase_cell(1, Vector2i(x, y))

func remove_highlights():
	# Tells the game there are no tiles which the player can move
	is_highlighted = false
	
	#removes the highlighted tile layers off the screen, including the navigation ones
	# just in case
	remove_attack_layer()
	remove_walkable_tiles()
	remove_nav_tiles()
	
	

func _on_ui_show_attack_range(inputbool):
	if inputbool == true and selected_unit !=null:
		var selected_units = game_map.local_to_map(selected_unit.global_position)
		for x in range(selected_units.x - 1, selected_units.x + 2):
			for y in range(selected_units.y - 1, selected_units.y + 2):
				var distance = abs(x - selected_units.x) + abs(y - selected_units.y)
				if distance-1 <= 1:
					game_map.set_cell(1, Vector2i(x, y), 1, Vector2i(0,0), 0)
		game_map.erase_cell(1, selected_units)			
	else:
		remove_attack_layer()

func _on_curser_moved(_new_cell):
	var current_mos = game_map.local_to_map(get_global_mouse_position())
	#checks if curser is in the walk region
	if current_mos in walkable_tiles:
		draw_astar = true
	else:
		draw_astar = false
	#if the curser is in the walk region, and the player isnt already moving
	if is_highlighted and can_walk and draw_astar:
		#Removes the navigation trail of previous path, so the new path can show
		remove_nav_tiles()
		#creates a vector array of the first and last positions in the tilemap of optimal route
		var movement_path = astar_grid.get_id_path(game_map.local_to_map(selected_unit.global_position),current_mos)
		#takes in that array that was made from astar pathing and draws the tiles ontop of it
		#aka draws player path
		game_map.set_cells_terrain_connect(3,movement_path, 0, 0)
		
		game_map.set_cell(3, game_map.local_to_map(selected_unit.global_position), 5, Vector2i(0, 0))

func remove_nav_tiles():
	game_map.clear_layer(3)
func remove_walkable_tiles():
	game_map.clear_layer(2)	
	walkable_tiles.clear()
func remove_attack_layer():
	game_map.clear_layer(1)


func _on_ui_character_sheet(toggle):
	if selected_unit != null:
		selected_unit.Sheet.visible = toggle
		$Camera2D.set_process(!toggle) # makes it so player cant move the camera with sheet open


func _on_ui_boosted_speed(check):
	use_boosted_s = check
