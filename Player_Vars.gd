extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var maxHP : int = 100

var unlockedMelee : bool = true
var unlockedSpeed : bool = true
var unlockedRanged : bool = false
var unlockedDodge : bool = false
var unlockedGrapple : bool = false
var unlockedAOE : bool = false

var isDodging : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
