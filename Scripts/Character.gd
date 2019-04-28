extends KinematicBody2D

# Abstract Class
# Inherited by any actors that use a character sprite to provide the basic functionalaity needed
# Basic functionality includes:
# Turning Sprint On and Off
# Moving Up, Down, Left, and Right
# Having animation during movement
# Updating position


const WALK_SPEED : int = 200
const SPRINT_SPEED : int = WALK_SPEED * 3

var sprinting : bool = false
var velocity : Vector2 = Vector2(0,0)

export var speed : float = 1.0 # Multiplier for the speed
