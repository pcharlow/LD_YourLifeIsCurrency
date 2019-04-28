extends "res://Scripts/Detector.gd"

# Inherited by enemy actors
# Provides:
#	Navigation variables

# Detection Variables
const ANGLE : float = 40.0
const SIGHT : float = 320.0

export var speed : float = 0.5 # Multiplier for the speed of this enemy
export var threshold : float = 5 # guards stop threshold

var velocity : Vector2
var possible []

func _ready():
	pass # Replace with function body.