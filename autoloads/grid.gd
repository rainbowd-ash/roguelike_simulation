#class_name Grid
extends Node

var tile_size : Vector2

func _ready() -> void:
	var world = get_node("/root/World")
	assert(world != null, "World node not found!")
	tile_size = world.tile_size

func grid_to_position(grid_position : Vector2i) -> Vector2:
	grid_position = Vector2(grid_position)
	return Vector2(grid_position.x * tile_size.x, grid_position.y * tile_size.y)

func position_to_grid(position : Vector2) -> Vector2i:
	var position_minus_tile_size = Vector2(position.x / tile_size.x, position.y / tile_size.y)
	var grid_position = Vector2i(position_minus_tile_size)
	return grid_position
