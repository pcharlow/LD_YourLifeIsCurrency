extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var ProjBody = $ProjectileBody
onready var ProjSprite = $ProjectileBody/AnimatedSprite

export var speed = 25

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


	#ProjBody.translate(ProjBody.transform.x.normalized() * speed)
	var coll = ProjBody.move_and_collide(ProjBody.transform.x.normalized() * speed)
	if coll:
		if coll.collider.name == "TargetBody":
			coll.collider.get_parent()._destroyed()
		if coll.collider.name == "Break1":
			coll.collider.get_parent().hitTarget(1)
		if coll.collider.name == "Break2":
			coll.collider.get_parent().hitTarget(2)
		if coll.collider.name == "Break3":
			coll.collider.get_parent().hitTarget(3)
		if coll.collider.name == "Break4":
			coll.collider.get_parent().hitTarget(4)
			
		queue_free()

	
	pass
