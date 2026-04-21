class_name Entity
extends Node2D

var grid_position : Vector2i
@onready var world: World = $"../.."

var movement_path : Array

var movespeed : int = 5
var wait : int = 0

func _ready() -> void:
	grid_position = Grid.position_to_grid(position)

func _physics_process(_delta: float) -> void:
	if wait == 0:
		ai()
	else:
		wait = wait - 1

func ai():
	if movement_path.size() == 0:
		var new_destination = Vector2i(randi_range(0,world.width),randi_range(0,world.height))
		movement_path = %AStarGrid.astar_grid.get_id_path(grid_position,new_destination)
	else:
		grid_position = movement_path.pop_front()
		position = Grid.grid_to_position(grid_position)
		wait = movespeed
