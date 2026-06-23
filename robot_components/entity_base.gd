class_name Entity
extends Node2D

@onready var world: World = $"../.."

var grid_position : Vector2i

var movement_path : Array
var current_destination : Vector2i

var movespeed : int = 7
var wait : int = 0

func _ready() -> void:
	grid_position = Grid.position_to_grid(position)

func _physics_process(_delta: float) -> void:
	if wait == 0:
		if movement_path.size() == 0:
			wander()
		else:
			continue_along_path()
	else:
		wait = wait - 1

func continue_along_path():
	grid_position = movement_path.pop_front()
	position = Grid.grid_to_position(grid_position)
	wait = movespeed

func wander():
	var new_destination = Vector2i(randi_range(0,world.width-1),randi_range(0,world.height-1))
	movement_path = NavigationGrid.astar_grid.get_id_path(grid_position,new_destination)
	wait = randi_range(20,45)
