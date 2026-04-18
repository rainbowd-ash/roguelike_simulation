class_name Builder
extends Node

signal changed_position

var world_position : Vector2i = Vector2i.ZERO

var movement_path : Array
var destination_tile = Vector2i(10,20)

func _physics_process(_delta: float) -> void:
	if world_position == destination_tile:
		return
	if movement_path.size() == 0:
		movement_path = %AStarGrid.astar_grid.get_id_path(world_position,destination_tile)
	var next_tile = movement_path.pop_front()
	move_to(next_tile)

func move_to(position : Vector2i):
	var prev_position = world_position
	world_position = position
	changed_position.emit({
		prev_position = prev_position,
		new_position = world_position
	})
