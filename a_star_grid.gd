extends Node

var astar_grid : AStarGrid2D

## Takes the boolean array and sets the pathfinding grid as appropriate
## true = empty spaces
## false = blocked spaces
func update_grid(empty_spaces:Array[Array]) -> void:
	astar_grid = AStarGrid2D.new()
	astar_grid.region = Rect2(0,0,empty_spaces[0].size(),empty_spaces.size())
	astar_grid.update()
	for y in empty_spaces.size():
		for x in empty_spaces[y].size():
			if empty_spaces[y][x] == false:
				astar_grid.set_point_solid(Vector2i(x,y))
	astar_grid.update()
