extends Node
class_name RobotPart

var bot : Entity

func _ready() -> void:
	bot = get_parent()
	bot.bot_moved.connect(on_bot_moved)

func on_bot_moved():
	pass
