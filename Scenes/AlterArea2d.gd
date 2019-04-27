extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var AlterText = $InteractText

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	pass


func _on_AlterArea2d_area_entered(area):
	AlterText.visible = true
	#print(area.get_name())
	
	
	pass # Replace with function body.


func _on_AltarArea2d_area_exited(area):
	AlterText.visible = false
	pass # Replace with function body.
