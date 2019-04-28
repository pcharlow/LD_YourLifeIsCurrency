extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.



func _ready():
	
	#var playerNode = $"/root/MainChar"
	#self.connect("_on_HPPackBody_area_entered", playerNode, "raiseHealth")
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#signal raiseHP


func _on_HPPackBody_area_entered( area):
	
	if area.get_name() == "MainCharArea":

		$PickupAudio.play(0)
		area.get_parent().get_parent()._raiseHealth(self,20)

	
	pass # Replace with function body.
