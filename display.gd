extends Node2D

func _ready() -> void:
	for child in %Entities.get_children():
		child.changed_position.connect(on_entity_changed_position)
	draw_everything()

func draw_everything():
	draw_terrain()
	draw_recharge_machines()
	draw_entities()

func draw_terrain():
	%TerrainTileMap.clear()
	var terrain = %World.terrain
	for y in terrain.size():
		for x in terrain[y].size():
			var sprite_id = terrain[y][x]
			%TerrainTileMap.set_cell(Vector2(x, y),0,terrain[y][x].sprite_id)

func draw_recharge_machines():
	%MachinesTileMap.clear()
	var tile = %RechargeMachines.tile
	for machine in %RechargeMachines.array_of_machines:
		var loc = Vector2(machine.x,machine.y)
		%MachinesTileMap.set_cell(Vector2(loc),0,tile)

func draw_entities():
	%EntitiesTileMap.clear()
	var entities = %Entities.get_children()
	for entity in entities:
		%EntitiesTileMap.set_cell(entity.world_position, 0, Vector2(3,6))

func on_terrain_changed(data):
	var tile = null
	var value = null
	if data.has("position"):
		tile = data.position
	if data.has("value"):
		value = data.value
	if not tile or not value:
		print("malformed terrain change call")
		return
	#$TerrainTileMap.set_cell(tile, 0, )

# this could get moved to the entities tilemaplayer later
func on_entity_changed_position(data):
	if data.has("prev_position"):
		%EntitiesTileMap.erase_cell(data.prev_position)
	if data.has("new_position"):
		%EntitiesTileMap.set_cell(data.new_position, 0, Vector2(3,6))
