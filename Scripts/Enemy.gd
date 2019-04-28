extends "res://Scripts/Character.gd"

# Abstract Class
# Inherited by enemy actors
# Provides:
#	Player Detection
#	Patrol Routing
#	State (Chasing Player, Returing to Patrol Route, on Patrol)

const UNIT_CIRCLE_ZERO : Vector2 = Vector2(1,0) # Zero degrees in vector format on the unit circle


func _ready():
	pass # Replace with function body.