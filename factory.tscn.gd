
extends Node2D
const launcher = preload("res://launcher.tscn")
const pusher = preload("res://pusher.tscn")
const triangle = preload("res://triangle.tscn")
const wall = preload("res://wall.tscn")
const voi = preload("res://void.tscn")
const floor = preload("res://floor.tscn")
@onready var button = $Button
var selectedtype = 0
var mousepos: Vector2
var dragging = false
var click_radius = 50
var current
var placedposition
var running = false
var dl
var dp
var dt
var ds
var dv
var mouseables
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var new_launcher = launcher.instantiate()
	new_launcher.position = Vector2(1050, 450)
	new_launcher.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(new_launcher)
	
	var new_pusher = pusher.instantiate()
	new_pusher.position = Vector2(1650, 450)
	add_child(new_pusher)
	
	var new_triangle = triangle.instantiate()
	new_triangle.position = Vector2(1050, 650)
	add_child(new_triangle)
	
	var new_square = wall.instantiate()
	new_square.position = Vector2(1650, 650)
	add_child(new_square)
	
	var new_voi = voi.instantiate()
	new_voi.position = Vector2(1350, 650)
	add_child(new_voi)
	
	
	
	dl = launcher.instantiate()
	new_launcher.position = Vector2(1050, 450)
	new_launcher.process_mode = Node.PROCESS_MODE_DISABLED
	add_child(dl)
	
	dp = pusher.instantiate()
	dp.position = Vector2(1650, 450)
	add_child(dp)
	
	dt = triangle.instantiate()
	dt.position = Vector2(1050, 650)
	add_child(dt)
	
	ds = wall.instantiate()
	ds.position = Vector2(1650, 650)
	add_child(ds)
	
	dv = voi.instantiate()
	new_voi.position = Vector2(1350, 650)
	add_child(dv)
	
	mouseables = [dl, dp, dt, ds, dv]
	for i in mouseables:
		i.visible = false
		i.process_mode = Node.PROCESS_MODE_DISABLED
	for i in range(9):
		for j in range(9):
			var newfloor = floor.instantiate()
			newfloor.position = Vector2(i*100+50, j*100+50)
			add_child(newfloor)
			
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if running:
		Global.runningtimer += delta
		if Global.runningtimer >= 10:
			for i in Global.grid:
				for j in i:
					if j != null:
						j.process_mode = Node.PROCESS_MODE_DISABLED
			Global.readyend = true
			running = false
	if selectedtype != 0 and not dragging:
		for i in mouseables:
			i.visible = false
		mouseables[selectedtype-1].visible = true
		mouseables[selectedtype-1].position = Vector2(floor(get_global_mouse_position().x/100.0)*100+50, floor(get_global_mouse_position().y/100.0)*100+50)
	else:
		for i in mouseables:
			i.visible = false
	
func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.keycode == KEY_1 and not event.echo and event.is_pressed():
		if selectedtype != 1:
			selectedtype = 1
		else:
			selectedtype = 0
	elif event is InputEventKey and event.keycode == KEY_2 and not event.echo and event.is_pressed():
		if selectedtype != 2:
			selectedtype = 2
		else:
			selectedtype = 0
	elif event is InputEventKey and event.keycode == KEY_3 and not event.echo and event.is_pressed():
		if selectedtype != 3:
			selectedtype = 3
		else:
			selectedtype = 0
	elif event is InputEventKey and event.keycode == KEY_4 and not event.echo and event.is_pressed():
		if selectedtype != 4:
			selectedtype = 4
		else:
			selectedtype = 0
	elif event is InputEventKey and event.keycode == KEY_5 and not event.echo and event.is_pressed():
		if selectedtype != 5:
			selectedtype = 5
		else:
			selectedtype = 0
	if running:
		if event is InputEventKey and event.keycode == KEY_ESCAPE:
			for i in Global.grid:
				for j in i:
					if j != null:
						j.process_mode = Node.PROCESS_MODE_DISABLED
			running = false
			Global.readyend = true
			button.restarted = true
		return
	elif (event is InputEventKey) and (event.keycode == KEY_SPACE)and (not running):
		Global.velocity = 0
		Global.balls = 0.00001
		Global.runningtimer = 0.01
		button.restarted = false
		running = true
		for i in Global.grid:
			for j in i:
				if j != null:
					j.process_mode = Node.PROCESS_MODE_INHERIT
		
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		placedposition = Vector2(floor(event.position.x/100.0)*100+50, floor(event.position.y/100.0)*100+50)
		if not dragging and event.pressed and Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)] == null and 9 > ((placedposition[1]-50)/100) and 9 > ((placedposition[0]-50)/100):
			dragging = true
			if selectedtype == 1:
				var new_launcher = launcher.instantiate()
				current = new_launcher
			elif selectedtype == 2:
				var new_pusher = pusher.instantiate()
				current = new_pusher
			elif selectedtype == 3:
				var new_triangle = triangle.instantiate()
				current = new_triangle
			elif selectedtype == 4:
				var new_wall = wall.instantiate()
				current = new_wall
			elif selectedtype == 5:
				var new_void = voi.instantiate()
				current = new_void
			else:
				dragging = false
				return
			Global.cost += current.cost()
			current.position = placedposition
			current.process_mode = Node.PROCESS_MODE_DISABLED
			add_child(current)
			Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)] = current
		if dragging and not event.pressed:
			dragging = false
			current = null
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_RIGHT:
		placedposition = Vector2(floor(event.position.x/100.0)*100+50, floor(event.position.y/100.0)*100+50)
		if Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)] != null:
			Global.cost -= Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)].cost()
			Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)].queue_free()
			Global.grid[((placedposition[1]-50)/100)][((placedposition[0]-50)/100)] = null
	if dragging and current != null and event.get("position") != null:
		current.rotation = round(placedposition.angle_to_point(event.position)/(PI/2))*PI/2
	
	
		
	
