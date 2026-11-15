extends Node
var grid
var velocity = 0
var balls = 0.000001
var runningtimer = 0.01
var readyend = false
var cost = 0
var mode = "td"
var turretdone = false
var tdgrid
var turrets = []
var lives = 10
var currentturret = -1
var money = 300
var aliveenemies = 0
var wavedonee = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	grid = []
	for i in range(30):
		var temp = []
		for j in range(30):
			temp.append(null)
		grid.append(temp)
	tdgrid = []
	for i in range(9):
		var temp = []
		for j in range(9):
			temp.append(null)
		tdgrid.append(temp)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if turretdone:
		turrets.append([velocity/balls/100, balls/runningtimer, cost])
		runningtimer = 0.01
		turretdone = false
	pass
