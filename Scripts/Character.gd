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

#warning-ignore:unused_class_variable
var sprinting : bool = false
#warning-ignore:unused_class_variable
var velocity : Vector2 = Vector2(0,0)

#warning-ignore:unused_class_variable
export var speed : float = 1.0 # Multiplier for the speed
