extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum NamedEnum {a = 0,b = 1}
export (NamedEnum) var SwitchNumber

var solved : bool = false
var pressed : bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	#getallnodes(get_parent())
	#getallnodes(get_parent())
	pass


func _on_StepArea_area_entered(area):
	
	#print(area.get_name())
	if area.get_name() == "MainCharArea":
		pressed = true
		getallnodes(get_parent())
		
		$StepArea/SpriteOff.visible= false
		$StepArea/SpriteOn.visible = true
		yield(get_tree().create_timer(1.5), "timeout")
		_CheckSolve()

		
	pass # Replace with function body.


func _CheckSolve():
	
	getallnodes(get_parent())
	if solved:
		$StepArea/SpriteOn.visible = true
		$StepArea/SpriteOff.visible = false
	else:
		pressed = false
		$StepArea/SpriteOn.visible = false
		$StepArea/SpriteOff.visible = true
	pass


func getallnodes(node):
	
	var a = false
	var b = false
	for N in node.get_children():
		if N.get_child_count() > 0:
			#print(N.get_name())
			#getallnodes(N)
			#if N.get_name() in "StepPuzzle":
			if "StepPuzzle" in N.get_name():
				print(N.SwitchNumber)
				if N.SwitchNumber == 0:
					if N.pressed == true:
						a = true
				elif N.SwitchNumber == 1:
					if N.pressed == true:
						b = true
	if a == true and b == true:
		solved = true
		print("SOLVED!!!")
        #else:
            # Do something
            #print("- "+N.get_name())