extends Node

var sprite_location : Vector2 = Vector2(2,5)

var array_of_machines : Array[Vector2]

## Takes a 2d boolean array of valid spaces
## Returns a list of vector2s with the locations
func distribute_randomly(valid_spaces:Array[Array], amount:int):
	# make a list of all the available spaces by coordinate, pick amount of them
		# probably a silly and inneficient way to do this but it doesn't matter since it happens during startup
			# hide it with an animation (^_-)-☆
	var list_of_spaces:Array[Vector2]
	for y in range(valid_spaces.size()):
		for x in range(valid_spaces[y].size()):
			list_of_spaces.append(Vector2(x,y))
	list_of_spaces.shuffle()
	array_of_machines = list_of_spaces.slice(0,amount)
	if amount > list_of_spaces.size():
		return array_of_machines
	return array_of_machines
