extends Button
var wavedone = true
var wavetimer = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	Global.wavedonee = wavedone
	if wavedone and wavetimer <= 0:
		text = "New Wave"
	elif wavetimer <= 0:
		text = "Enemies Remaining: " + str(Global.aliveenemies)
	else:
		text = str(snapped(wavetimer, 0.01)) + "s remaining"
