extends "res://Scripts/Character.gd"

# Abstract Class
# Characters that can detect if the Player is within their line of sight
# Requires a sight range (Length) and sight angle (Width) 

const UNIT_CIRCLE_ZERO : Vector2 = Vector2(1,0) # Zero degrees in vector format on the unit circle.

onready var Player = Player_Vars.Player

signal inView
signal outOfView

var angle : float
var sight : float

func setAngle(a) -> void:
	angle = a/2 # Half the angle to account for the current rotation vector cutting the angle
	
func setSight(s) -> void:
	sight = s
	
func playerInFOV() -> void:
	var currentRotation = UNIT_CIRCLE_ZERO.rotated(global_rotation) # Convert our rotation to a normalized vector
	var directionOfPlayer = (Player.position - global_position).normalized() # Obtain the direction of the player and normalize it
	
	if abs(directionOfPlayer.angle_to(currentRotation)) < deg2rad(angle) && playerInLOS():
		emit_signal("detected")
	else:
		emit_signal("undetected")
		
func playerInLOS():
	var space = get_world_2d().direct_space_state
	var obstruction = space.intersect_ray(global_position, Player.position, [self], collision_mask)
	var distance = Player.global_position.distance_to(global_position)
	
	return obstruction.collider == Player && distance < sight