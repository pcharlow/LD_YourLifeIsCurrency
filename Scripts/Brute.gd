extends "res://Scripts/Enemy.gd"

# Brute Enemy
# Patrols a path while Player is not in sight

var chasing : bool = false

func _ready():
	connect("inView", self, "_on_inView")
	connect("outOfView", self, "_on_outOfView")

func _on_inView():
	print("I see you")
	
func _on_outOfView():
	pass