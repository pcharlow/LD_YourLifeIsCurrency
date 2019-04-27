extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ProjBody = $ProjectileBody
onready var ProjSprite = $ProjectileBody/AnimatedSprite

export var speed = 20

var pos = Vector2()
var dir : float = 0


var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	ProjBody.position = pos
	ProjBody.rotation_degrees = dir
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	ProjBody.translate(ProjBody.transform.x.normalized() * speed)

	pass
