class_name World
extends Node

var width : int = 100
var height : int = 60

var terrain : Array[Array]

## Terrains
var FLOOR = preload("res://tiles/terrain_tiles/floor.tres")
var WALL = preload("res://tiles/terrain_tiles/wall.tres")

func _ready() -> void:
	world_gen()
	#%ProcGen/FactoryLayout.generate_factory_floor()
	#%AStarGrid.update_grid()

func world_gen():
	terrain.clear()
	var floor_space:Array[Array]
	for y in height:
		var row := []
		for x in width:
			row.append(true)
		floor_space.append(row)
	for y in height:
		var row := []
		for x in width:
			row.append(FLOOR)
		terrain.append(row)
	var rechargers = %RechargeMachines.distribute_randomly(floor_space,4)
	for i in rechargers.size():
		var location = rechargers[i]
		floor_space[location.y][location.x] = false
	%AStarGrid.update_grid(floor_space)

func set_cell(location : Vector2i, value) -> void:
	var x = location.x
	var y = location.y
	if x < 0 or x >= width:
		return
	if y < 0 or y >= height:
		return
	terrain[y][x] = value

func rectangle_procgen():
	var top_left = Vector2i(randi_range(0, width),(randi_range(0,height)))
	var size = Vector2i(randi_range(4,10), randi_range(4,10))
	for y in size.y:
		for x in size.x:
			if x == 0 or x == size.x - 1 or y == 0 or y == size.y - 1:
				var cell = top_left + Vector2i(x, y)
				set_cell(cell, WALL)
	%Display.draw_terrain()
