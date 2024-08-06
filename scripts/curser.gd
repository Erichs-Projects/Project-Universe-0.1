## Player-controlled cursor. Allows them to navigate the game grid, select units, and move them.
## Supports both keyboard and mouse (or touch) input.
class_name Cursor
extends Node2D

## Emitted when clicking on the currently hovered cell or when pressing "ui_accept".
signal accept_pressed(cell)
## Emitted when the cursor moved to a new cell.
signal moved(new_cell)

## Grid resource, giving the node access to the grid size, and more.
@export var tilemap_stored: Resource
## Time before the cursor can move again in seconds.
@export var ui_cooldown := 0.1

## Coordinates of the current cell the cursor is hovering.
var cell := Vector2.ZERO:
	set(value):
		# We first clamp the cell coordinates and ensure that we aren't
		#	trying to move outside the grid boundaries
		var new_cell: Vector2 = tilemap_stored.grid_clamp(value)
		if new_cell.is_equal_approx(cell):
			return

		cell = new_cell
		# If we move to a new cell, we update the cursor's position, emit
		#	a signal, and start the cooldown timer that will limit the rate
		#	at which the cursor moves when we keep the direction key held
		#	down
		position = tilemap_stored.calculate_tilemap_to_global_cords(cell)
		
		emit_signal("moved", cell)
		_timer.start()

@onready var _timer: Timer = $Timer


func _ready() -> void:
	
	_timer.wait_time = ui_cooldown
	position = tilemap_stored.calculate_tilemap_to_global_cords(cell)


func _unhandled_input(event: InputEvent) -> void:

	# Navigating cells with the mouse.
	if event is InputEventMouseMotion:
		# event.position
		cell = tilemap_stored.calculate_global_to_tilemap_cords(get_global_mouse_position())
		
	
	var should_move := event.is_pressed() 
	if event.is_echo():
		should_move = should_move and _timer.is_stopped()

	if not should_move:
		return
	
	# Moves the cursor by one grid cell.
	if event.is_action("right"):
		cell += Vector2.RIGHT
	elif event.is_action("up"):
		cell += Vector2.UP
	elif event.is_action("left"):
		cell += Vector2.LEFT
	elif event.is_action("down"):
		cell += Vector2.DOWN


func _draw() -> void:
	draw_rect(Rect2(-tilemap_stored.cell_size / 2, tilemap_stored.cell_size), Color.LIGHT_BLUE, false, 2.0)

