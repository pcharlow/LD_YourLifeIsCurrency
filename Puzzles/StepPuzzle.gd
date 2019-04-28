extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

enum NamedEnum {a = 0,b = 1,c= 2,d = 3}
export (NamedEnum) var SwitchNumber

export var time : float = 1.5

var complete1 : bool = false
var complete2 : bool = false
var solved1 : bool = false
var solved2 : bool = false
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
		yield(get_tree().create_timer(time), "timeout")
		_CheckSolve()

		
	pass # Replace with function body.


func _CheckSolve():
	
	if SwitchNumber < 2:
		if not complete1:
			getallnodes(get_parent())
			if solved1:
				complete1 = true
				$StepArea/SpriteOn.visible = true
				$StepArea/SpriteOff.visible = false
				get_parent().get_node("LevelChanger").solveCount +=1
				
			else:
				pressed = false
				$StepArea/SpriteOn.visible = false
				$StepArea/SpriteOff.visible = true
				
	else:
		if not complete2:
			getallnodes(get_parent())
			if solved2:
				complete2 = true
				$StepArea/SpriteOn.visible = true
				$StepArea/SpriteOff.visible = false
				get_parent().get_node("LevelChanger").solveCount +=1
				
			else:
				pressed = false
				$StepArea/SpriteOn.visible = false
				$StepArea/SpriteOff.visible = true
	
	pass


func getallnodes(node):
	
	var a = false
	var b = false
	var c = false
	var d = false
	
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
				elif N.SwitchNumber == 2:
					if N.pressed == true:
						c = true
				elif N.SwitchNumber == 3:
					if N.pressed == true:
						d = true
	if a == true and b == true:
		solved1= true
	if c == true and d == true:
		solved2= true
		#_CheckSolve()
		#print("SOLVED!!!")
        #else:
            # Do something
            #print("- "+N.get_name())