class_name Entity
extends Node2D

@export var power_source : PowerSource

var grid_position : Vector2i

var movement_path : Array
var destination_tile = Vector2i(10,20)

var movespeed : int = 30
var wait : int = 0

func _ready() -> void:
	grid_position = Grid.position_to_grid(position)

func _physics_process(_delta: float) -> void:
	if wait == 0:
		move_along_path()
	else:
		wait = wait - 1
	

func move_along_path():
	if grid_position == destination_tile:
		return
	if movement_path.size() == 0:
		movement_path = %AStarGrid.astar_grid.get_id_path(grid_position,destination_tile)
	var next_tile = movement_path.pop_front()
	position = Grid.grid_to_position(next_tile)
	wait = movespeed
