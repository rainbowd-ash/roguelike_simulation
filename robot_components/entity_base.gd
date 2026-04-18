class_name Entity
extends Node

@export var power_source : PowerSource

var world_position : Vector2i = Vector2i.ZERO

func move_to(position : Vector2i):
	var prev_position = world_position
	world_position = position
