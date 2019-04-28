extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var Break1 = $Break1
onready var Break2 = $Break2
onready var Break3 = $Break3
onready var Break4 = $Break4

var solved : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if not solved:
		if Break1.visible == false and Break2.visible == false and Break3.visible == false and Break4.visible == false:
			print("SOLVED")
			get_parent().get_node("LevelChanger").Disabled = false
			#Break1.queue_free()
			#Break2.queue_free()
			#Break3.queue_free()
			#Break4.queue_free()
			solved = true
	
	
	pass


func CheckForSolve(obj, obj2):
	
	if not solved:
		obj.visible = true
		obj2.disabled = false
	
	pass

func hitTarget(TargetNumber):
	
	if TargetNumber == 1:
		Break1.visible = false
		$Break1/Break1Collider.disabled = true
		yield(get_tree().create_timer(.75), "timeout")
		CheckForSolve(Break1,$Break1/Break1Collider)

		
	if TargetNumber == 2:
		Break2.visible = false
		$Break2/Break2Collider.disabled = true
		yield(get_tree().create_timer(.75), "timeout")
		CheckForSolve(Break2,$Break2/Break2Collider)
		
	if TargetNumber == 3:
		Break3.visible = false
		$Break3/Break3Collider.disabled = true
		yield(get_tree().create_timer(.75), "timeout")
		CheckForSolve(Break3,$Break3/Break3Collider)
		
	if TargetNumber == 4:
		Break4.visible = false
		$Break4/Break4Collider.disabled = true
		yield(get_tree().create_timer(.75), "timeout")
		CheckForSolve(Break4,$Break4/Break4Collider)
	pass
