extends "res://Scripts/Character.gd"

# Abstract Class
# Characters that can detect if the Player is within their line of sight
# Requires a sight range (Length) and sight angle (Width) 

const UNIT_CIRCLE_ZERO : Vector2 = Vector2(1,0) # Zero degrees in vector format on the unit circle.

signal inView
signal outOfView

var Player
export var angle : float = 40.0
export var sight : float = 320.0

func setPlayer(p) -> void:
	Player = p
	
func playerInFOV() -> void:
	var currentRotation = UNIT_CIRCLE_ZERO.rotated(global_rotation) # Convert our rotation to a normalized vector
	var directionOfPlayer = (Player.position - global_position).normalized() # Obtain the direction of the player and normalize it
	
	if abs(directionOfPlayer.angle_to(currentRotation)) < deg2rad(angle) && playerInLOS():
		emit_signal("inView")
	else:
		emit_signal("outOfView")
		
func playerInLOS():
	var space = get_world_2d().direct_space_state
	var obstruction = space.intersect_ray(global_position, Player.position, [self], collision_mask)
	var distance = Player.global_position.distance_to(global_position)
	
	return obstruction.collider == Player && distance < sight