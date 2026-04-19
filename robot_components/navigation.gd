class_name Navigation
extends Node

var grid_position : Vector2i

var movement_path : Array
var destination_tile = Vector2i(10,20)

func _ready() -> void:
	grid_position = Grid.position_to_grid(get_parent().position)

func _physics_process(_delta: float) -> void:
	if grid_position == destination_tile:
		return
	if movement_path.size() == 0:
		movement_path = %AStarGrid.astar_grid.get_id_path(grid_position,destination_tile)
	var next_tile = movement_path.pop_front()
	get_parent().position = Grid.grid_to_position(grid_position)
