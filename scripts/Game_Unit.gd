extends Path2D
signal walked_finished()

@export var Character: CharacterAttributes

var Char_race
@onready var Sheet = $Sheet
var size_of_curve: int = 0
@export var grid: Resource
@onready var label = $PathFollow2D/Label
@onready var path: PathFollow2D = $PathFollow2D
@export var move_speed: int = 100


var cell := Vector2.ZERO:
	set(value):
		# When changing the cell's value, we don't want to allow coordinates outside
		#	the grid, so we clamp them
		cell = grid.grid_clamp(value)
var _is_walking := false:
	set(value):
		_is_walking = value
		#once our bool is changed to true, it will begin running the process function to move it
		set_process(_is_walking)
var is_selected:= false:
	set(value):
		is_selected = value
		if is_selected:
			play_selection()
		else:
			play_idle()


func _ready():
	cell = grid.calculate_global_to_tilemap_cords(position)
	$PathFollow2D.loop = false
	$PathFollow2D.rotates = false
	if not Engine.is_editor_hint():
		curve = Curve2D.new()
	play_idle()
	path.progress = 0
	#Character = CharacterAttributes.new(Char_race, PowerLevel)
	Sheet.visible = false

func _physics_process(delta):
	#moves the character along our assigned path in our moved_character func
	path.progress += move_speed * delta

	if path.progress_ratio >= 1.0:
		path.progress = 0.0000001
		
		position = grid.calculate_tilemap_to_global_cords(cell)
		curve.clear_points()
		
		_is_walking = false
			# Setting this value to 0.0 causes a Zero Length Interval error
		$Timer.start()

func play_selection():
	$AnimationPlayer.play('selected_ani')
func play_idle():
	$AnimationPlayer.play('Idle')

func move_character(animation_path):
	if animation_path.is_empty():
		return
	for point in animation_path.size():
		curve.add_point(grid.calculate_tilemap_to_global_cords(animation_path[point])-position)
		#use the astar points we feed in to get a path for the character to move
	_is_walking = true
	cell = animation_path[-1]
	
func _on_timer_timeout():
	walked_finished.emit()


func create_npc():
	Character = CharacterAttributes.new(Char_race)
	if Char_race.agility == 1:
		label.text = "Saiyan"
