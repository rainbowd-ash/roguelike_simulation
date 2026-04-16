extends Node

var tile : Vector2 = Vector2(2,5)

## Takes a 2d boolean array of valid spaces
## Returns a 2d bool array of placements
func distribute_randomly(terrain:Array[Array], amount:int):
	if amount == null:
		amount = 4
	print(str(amount))
