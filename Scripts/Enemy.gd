extends "res://Scripts/Detector.gd"

# Inherited by enemy actors
# Provides:
#	Navigation variables

# Detection Variables
const ANGLE : float = 40.0
const SIGHT : float = 320.0

export var speed : float = 0.5 # Multiplier for the speed of this enemy
export var threshold : float = 5 # Enemy stop threshold

var possible = [] # All possible points the enemy may go to

func _ready():
	pass # Replace with function body.