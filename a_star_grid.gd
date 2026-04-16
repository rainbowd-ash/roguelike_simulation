extends Node

var astar_grid : AStarGrid2D

func update_grid() -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2(0,0,%World.width, %World.height)
	astar_grid.update()
	var terrain = %World.terrain
	for y in terrain.size():
		for x in terrain[y].size():
			if terrain[y][x].obstacle:
				astar_grid.set_point_solid(Vector2i(x,y))
	astar_grid.update()
