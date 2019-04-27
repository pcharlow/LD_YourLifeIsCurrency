extends Node2D

# Declare member variables here. Examples:

const UP = 0
const LEFT = 1
const DOWN = 2
const RIGHT =3

#char variables
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
	
	pass
