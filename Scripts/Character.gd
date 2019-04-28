extends Node2D

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

func _physics_process(delta) -> void:
	$KinematicBody2D.move_and_slide(velocity)

func sprint() -> void:
    sprinting = !sprinting

func moveUp()-> void:
    if sprinting:
        velocity.y += -SPRINT_SPEED
    else:
        velocity.y += -WALK_SPEED

func moveLeft()-> void:
    if sprinting:
        velocity.x += -SPRINT_SPEED
    else:
        velocity.x += -WALK_SPEED

func moveDown()-> void:
    if sprinting:
        velocity.y += SPRINT_SPEED
    else:
        velocity.y += WALK_SPEED

func moveRight()-> void:
    if sprinting:
        velocity.x += SPRINT_SPEED
    else:
        velocity.x += WALK_SPEED

func stopMovement()-> void:
    velocity = Vector2(0,0)

