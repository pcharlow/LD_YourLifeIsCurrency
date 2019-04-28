extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var AlterText = $InteractText
onready var AlterArea = $AlterArea2d

enum NamedEnum {HpBoost, SpawnEnemy, Shortcut = -1}
export (NamedEnum) var AltarType
# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	
	pass

