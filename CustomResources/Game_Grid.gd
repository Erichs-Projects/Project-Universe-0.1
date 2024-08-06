class_name Game_Grid
extends Resource

# The square in area of the tilemap width x, height y
@export var region: Rect2i = Rect2i(16, 16, 16, 16)
#tilemaps rows and collumns
@export var size:= Vector2i(16, 16)
## The size of a cell in pixels.
@export var cell_size := Vector2(32, 32)

## Half of ``cell_size``
var _half_cell_size = cell_size / 2

# tilemap to global
func calculate_tilemap_to_global_cords(global_pos: Vector2) -> Vector2:
	return global_pos * cell_size + _half_cell_size


# global to tilemap
func calculate_global_to_tilemap_cords(map_position: Vector2) -> Vector2:
	return (map_position / cell_size).floor()


## Returns true if the `cell_coordinates` are within the tilemap square.
func is_within_bounds(cell_coordinates: Vector2) -> bool:
	var out := cell_coordinates.x >= 0 and cell_coordinates.x < size.x
	return out and cell_coordinates.y >= 0 and cell_coordinates.y < size.y
# a bool if that returns just our given the x and y parameters

## Makes the global_pos` fit within the tiemap's square bounds.
func grid_clamp(global_pos: Vector2) -> Vector2:
	var out := global_pos
	out.x = clamp(out.x, 0, size.x - 1.0)
	out.y = clamp(out.y, 0, size.y - 1.0)
	return out
