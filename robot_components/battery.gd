extends RobotPart

var movement_cost : int = 1 # this should be a property of the bot (so other parts can modify it)
var charge_stored : int = 100

func on_bot_moved():
	charge_stored -= movement_cost
	if charge_stored <= 0:
		print("batt drop")
		charge_stored = 100
