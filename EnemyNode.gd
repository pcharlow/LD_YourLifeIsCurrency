extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var inSight : bool = false
var player 
var alter : bool = false
var canDamage = true
const Pack = preload("res://HPPack.tscn")

export var HP = 50
export var speed = 50

onready var myBod = $EnemyBody

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	
	pass # Replace with function body.




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var direction = Vector2()
	var motion = Vector2()
	var velocity = Vector2()
	if inSight:
		$EnemyBody/DetectArea/LargeDetect.disabled = false
		myBod.look_at(player.global_position)
		
		#var motion = Vector2()
		

		direction = (player.get_parent().get_parent().player.global_position - myBod.global_position).normalized()
		motion = direction * speed * delta
		#position += motion

		var coll = myBod.move_and_collide(motion)#.normalized() * delta)
		if coll:
			if coll.collider.name == "MainCharBody":
				if canDamage:
					canDamage = false
					coll.collider.get_parent().HP -=4
					yield(get_tree().create_timer(.5), "timeout")
					canDamage = true
				#print("collide")
				
	else:
		$EnemyBody/DetectArea/LargeDetect.disabled = true
	pass


func _on_DetectArea_area_entered(area):
	
	
	if area.get_name() == "MainCharArea":
		#print(area.get_parent().get_parent().get_name())
		player = area
		myBod.look_at(area.global_position)
		inSight = true

		
		

			
	pass # Replace with function body.


func _on_DetectArea_area_exited(area):
	if area.get_name() == "MainCharArea":
		inSight = false
	
	pass # Replace with function body.


func _on_BodyArea_area_entered(area):
	print(area.get_name())
	if area.get_name() == "Melee":
		HP -= 20
	if area.get_name() == "ProjectileArea":
		area.get_parent().get_parent().queue_free()
		HP -= 30
	if area.get_name() == "AoeArea":
		HP -= 50
	
	if HP <= 0:
		var pack = Pack.instance()
		pack.global_position = myBod.global_position
		if alter:
			pack.get_node("HPPackBody").healAmount = 50
			#ranged.dir = player.rotation_degrees
		get_parent().add_child(pack)
		queue_free()
	
	pass # Replace with function body.
