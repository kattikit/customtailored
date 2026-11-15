extends Button
var wavedone = true
var turretcost = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if wavedone:
		text = "Design Turret: $" + str(turretcost)
	else:
		text = "Wave in progress"
func _button_pressed():
	if wavedone:
		if Global.money >= turretcost:
			Global.money -= turretcost
			Global.mode = "factory"
		
