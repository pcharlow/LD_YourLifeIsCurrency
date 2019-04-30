extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var aud = self.get_node("AudioNode")
# Called when the node enters the scene tree for the first time.
func _ready():
	var nextSound = aud.get_node("NextLevel")
	nextSound.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
