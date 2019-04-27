extends Node2D

# Declare member variables here. Examples:
onready var player = $MainCharBody
onready var playerText = $MainCharBody/TestLabel
const UP = 0
const LEFT = 1
const DOWN = 2
const RIGHT =3

#char variables
var gameover : bool = false

var maxHP : int = 100
var HP : int = 100
var speed : int = 200
var isMoving : bool = false
var movement = Vector2()

#potentially unneeded
var direction : int = 0
var horMoving : bool = false
var vertMoving : bool = true
var movingDiagonal : bool = false

#unlocked abilites
var unlockedMelee : bool = true
var unlockedRanged : bool = false
var unlockedDodge : bool = false
var unlockedGrapple : bool = false
var unlockedSpeed : bool = false
var unlockedAOE : bool = false

#cooldowns
var canMove : bool = true

var canMelee : bool = true
var canDodge : bool = true
var canRanged : bool = true
var canGrapple : bool = true
var canSpeed : bool = true
var canAOE : bool = true




# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


func _GetInput():
	
	movement = Vector2()
	isMoving = Input.is_action_pressed("mainChar_up") or Input.is_action_pressed("mainChar_down") or Input.is_action_pressed("mainChar_left") or Input.is_action_pressed("mainChar_right")
	#vertMoving = Input.is_action_pressed("mainChar_up") or Input.is_action_pressed("mainChar_down")
	#horMoving = Input.is_action_pressed("mainChar_right") or Input.is_action_pressed("mainChar_left")
	
	if Input.is_action_pressed("mainChar_up"):
		movement.y -= 1
	if Input.is_action_pressed("mainChar_down"):
		movement.y += 1
	if Input.is_action_pressed("mainChar_left"):
		movement.x -= 1
	if Input.is_action_pressed("mainChar_right"):
		movement.x += 1
			
	movement = movement.normalized() * speed
	
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#position = player.position
	#rotation = get_global_mouse_position().angle_to_point(player.position)
	_GetInput()
	player.look_at(get_global_mouse_position())
	
	
	playerText.text = str(movement)
	if canMove:
			
		if isMoving:
			 player.move_and_slide(movement)
		
		#if vertMoving and horMoving:
		#	movingDiagonal = true
		
	
	
	pass
