extends Node

var sprite_location : Vector2 = Vector2(2,5)

var array_of_machines : Array
var machine_locations : Array[Vector2i]

func _ready() -> void:
	array_of_machines = get_children()
	for child in array_of_machines:
		machine_locations.append(Grid.position_to_grid(child.position))
	print(str(machine_locations))
