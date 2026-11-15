extends Button
var restarted = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(_button_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if restarted:
		text = "Simulation Halted"
		return
	if Global.runningtimer < 10:
		if Global.runningtimer == 0.01:
			text = "Generate Stats"
		else:
			text = str(snapped(10-Global.runningtimer, 0.01)) + "s remaining"
	else:
		text = "Finish Turret"
	pass
func _button_pressed():
	if Global.runningtimer < 10:
		var press_event = InputEventKey.new()
		press_event.keycode = KEY_SPACE
		press_event.pressed = true
		Input.parse_input_event(press_event)
	else:
		Global.turretdone = true
		Global.currentturret += 1
		Global.mode = "td"
		
