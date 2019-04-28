extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var aud = self.get_parent().get_parent().get_parent().get_node("AudioNode")
onready var AlterText = $InteractText

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	
	pass


func _on_AlterArea2d_area_entered(area):
	AlterText.visible = true
	area.get_parent().get_parent().canInteract = true
	var myType = self.get_parent().get_parent().AltarType

	if myType == 0:
		area.get_parent().get_parent().AltarText = "Would you like to sacrifice 50hp for 10 more max HP?"
		area.get_parent().get_parent().interactionType = 0
	elif myType == 1:
		area.get_parent().get_parent().AltarText = "Would you, like to spend 10HP to spawn an enemy?"
		area.get_parent().get_parent().interactionType = 1		
		
	elif myType == -1:
		area.get_parent().get_parent().AltarText = "Would you, like to spend 75HP to for a shortcut?"
		area.get_parent().get_parent().interactionType = 2
	#print(area.get_name())
	var SwirlSound = aud.get_node("AltarSwirl")
	SwirlSound.play()
	
	pass # Replace with function body.


func _on_AltarArea2d_area_exited(area):
	AlterText.visible = false
	area.get_parent().get_parent().canInteract = false
	var SwirlSound = aud.get_node("AltarSwirl")
	SwirlSound.stop()	
	
	
	pass # Replace with function body.
