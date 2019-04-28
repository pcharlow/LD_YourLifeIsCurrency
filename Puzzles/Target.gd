extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var  TargetTrigger : bool = false
onready var aud = get_parent().get_node("AudioNode")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _destroyed():
	var targetSound = aud.get_node("TargetBreak")
	targetSound.play()
	#$TargetBreak.play()
	if TargetTrigger:
		#get_parent().get_name()
		get_parent().get_node("LevelChanger").solveCount +=1
		#print(get_parent().getnode("LevelChanger"))
	else:
		get_parent().get_node("MainChar")._raiseHp(10)
	queue_free()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
