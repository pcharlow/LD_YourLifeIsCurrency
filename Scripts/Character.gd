extends Node2D

# Abstract Class
# Inherited by any actors that use a character sprite to provide the basic functionalaity needed
# Basic functionality includes:
# Turning Sprint On and Off
# Moving Up, Down, Left, and Right
# Having animation during movement
# Updating position


const WALK_SPEED : int = 200
const SPRINT_SPEED: int = WALK_SPEED * 3

var sprinting : bool = false
var velocity : Vector2 = Vector2(0,0)

func _physics_process(delta):
	checkInput()
	$KinematicBody2D.move_and_slide(velocity)

func sprint() -> void:
    sprinting = !sprinting

func moveUp():
    if sprinting:
        velocity.y += -SPRINT_SPEED
    else:
        velocity.y += -WALK_SPEED

func moveLeft():
    if sprinting:
        velocity.x += -SPRINT_SPEED
    else:
        velocity.x += -WALK_SPEED

func moveDown():
    if sprinting:
        velocity.y += SPRINT_SPEED
    else:
        velocity.y += WALK_SPEED

func moveRight():
    if sprinting:
        velocity.x += SPRINT_SPEED
    else:
        velocity.x += WALK_SPEED

func stopMovement():
    velocity = Vector2(0,0)


#temporary
func checkInput() -> void:
    $KinematicBody2D.look_at(get_global_mouse_position())
    stopMovement()
    if Input.is_action_just_pressed("sprint") || Input.is_action_just_released("sprint"):
        sprint()
    if Input.is_action_pressed("ui_down"):
        moveDown()
    if Input.is_action_pressed("ui_up"):
        moveUp()
    if Input.is_action_pressed("ui_right"):
        moveRight()
    if Input.is_action_pressed("ui_left"):
        moveLeft()
