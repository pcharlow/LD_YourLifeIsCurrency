extends Node2D

# Declare member variables here. Examples:

const UP = 0
const LEFT = 1
const DOWN = 2
const RIGHT =3

#char variables
var gameover : bool = false

var maxHP : int = 100
var HP : int = 100
var speed : int = 100
#potentially unneeded
var direction : int = 0

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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var isMoving = Input.is_action_pressed("mainChar_up") or Input.is_action_pressed("mainChar_down") or Input.is_action_pressed("mainChar_left") or Input.is_action_pressed("mainChar_right")
	
	var horMoving : bool = false
	var vertMoving : bool = true
	var movingDiagonal : bool = false
	
	if canMove:
		
		if isMoving:
			
			if Input.is_action_pressed("mainChar_up"):
				vertMoving = true
				
			if Input.is_action_pressed("mainChar_down"):
				vertMoving = true
				
			if Input.is_action_pressed("mainChar_left"):
				horMoving = true
				
			if Input.is_action_pressed("mainChar_right"):
				horMoving = true
				
				
				
		if vertMoving and horMoving:
			movingDiagonal = true
		
	
	
	pass
