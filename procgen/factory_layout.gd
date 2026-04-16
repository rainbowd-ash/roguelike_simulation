extends Node

@onready var world: World = %World

var world_height : int
var world_width : int

func _ready() -> void:
	world_height = world.height
	world_width = world.width

func generate_factory_floor():
	var room_count : int = 10
	var padding : int = -1
	var room_size_min : int = 14
	var room_size_max : int = 26
	var bounds : Rect2i = Rect2i(0,0,0,0)
	
	if bounds == Rect2i(0,0,0,0):
		bounds = Rect2i(0, 0, world_width, world_height)
	
	var rooms : Array = []
	var fail_counter : int = 0
	
	while rooms.size() < room_count:
		if fail_counter > 1000:
			#print("i couldnt figur it out")
			fail_counter = 0
			rooms.clear()
		var w = randi_range(room_size_min, room_size_max)
		var h = randi_range(room_size_min, room_size_max)
		var pos = Vector2i(
			randi_range(0, world_width - w),
			randi_range(0, world_height - h)
		)
		var new_room = Rect2i(pos, Vector2i(w, h))
		# overlap check with padding
		var expanded = Rect2i(
			new_room.position - Vector2i(padding, padding),
			new_room.size + Vector2i(padding * 2, padding * 2)
		)
		var overlaps := false
		if not bounds.encloses(expanded):
			overlaps = true
		for room in rooms:
			if expanded.intersects(room):
				overlaps = true
				break
		if overlaps:
			fail_counter += 1
			continue
		rooms.append(new_room)
	# carve rooms
	#print("I messed up " + str(fail_counter) + " times.")
	for room in rooms:
		for y in range(room.size.y):
			for x in range(room.size.x):
				if x == 0 or x == room.size.x - 1 or y == 0 or y == room.size.y - 1:
					var cell = room.position + Vector2i(x, y)
					world.set_cell(cell, world.WALL)
	# place doors after all outlines are drawn
	for room in rooms:
		var door_count = randi_range(1, 3)
		var perimeter : Array = []
		# collect valid door positions (edges only, no corners)
		for x in range(1, room.size.x - 1):
			perimeter.append(room.position + Vector2i(x, 0))
			perimeter.append(room.position + Vector2i(x, room.size.y - 1))
		for y in range(1, room.size.y - 1):
			perimeter.append(room.position + Vector2i(0, y))
			perimeter.append(room.position + Vector2i(room.size.x - 1, y))
		perimeter.shuffle()
		var placed = 0
		for cell in perimeter:
			if placed >= door_count:
				break
			# skip if on the world boundary
			if cell.x <= 0 or cell.x >= world_width - 1 or cell.y <= 0 or cell.y >= world_height - 1:
				continue
			world.set_cell(cell, world.FLOOR)
			placed += 1
