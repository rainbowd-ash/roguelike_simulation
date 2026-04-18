class_name Entity
extends Node

signal changed_position

@export var power_source : PowerSource

var world_position : Vector2i = Vector2i.ZERO

func move_to(position : Vector2i):
	var prev_position = world_position
	world_position = position
	changed_position.emit({
		prev_position = prev_position,
		new_position = world_position
	})
