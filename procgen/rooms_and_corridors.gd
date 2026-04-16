extends Node

@onready var world: World = %World

var world_height : int
var world_width : int

func _ready() -> void:
	world_height = world.height
	world_width = world.width

func generate_rooms_and_corridors(
	room_count : int = 10, 
	padding : int = 2, 
	room_size_min : int = 9,
	room_size_max : int = 20,
	bounds : Rect2i = Rect2i(0,0,0,0)):
	
	if bounds == Rect2i(0,0,0,0):
		bounds = Rect2i(0, 0, world_width, world_height)
	
	var rooms : Array = []
	var fail_counter : int = 0
	
	while rooms.size() < room_count:
		if fail_counter > 3000:
			print("i couldnt figur it out")
			return
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
	print("I messed up " + str(fail_counter) + " times.")
	for room in rooms:
		for y in range(room.size.y):
			for x in range(room.size.x):
				var cell = room.position + Vector2i(x, y)
				world.set_cell(cell, world.FLOOR)
