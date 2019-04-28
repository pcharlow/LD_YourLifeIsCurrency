extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var labelSwap = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	

	
	if not labelSwap:
		if Player_Vars.unlockedRanged:
			labelSwap = true
			$MainChar/MainCharBody/Line2D.visible = true
			$Label3.visible = false
			$Label4.visible =  true
		
		#"Congrats, you have unlocked the ranged Bloodshot attack. Right Mouse Button to shoot, try shooting that target. Careful, Bloodshots cost health."
	
	
	pass
