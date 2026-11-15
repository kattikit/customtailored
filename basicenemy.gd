extends Area2D
var speed = 0
var hp = 99999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("enemy")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += speed*delta
	if hp <= 0:
		Global.money += 5
		queue_free()
		Global.aliveenemies -= 1
	if position.y > 950:
		Global.lives -= 1
		Global.alivenemies -= 1
		queue_free()
func damage(d):
	print(hp)
	hp -= d
	print(hp)
