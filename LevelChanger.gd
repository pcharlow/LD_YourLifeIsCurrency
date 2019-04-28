extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(String, FILE, "*tscn") var worldScene
export var Disabled : bool = true
export var puzzleCount : int = 1
var solveCount = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if solveCount == puzzleCount:
		Disabled = false
	
	if Disabled:
		$LevelArea/Sprite.visible = false
		$LevelArea/Sprite2.visible = true
	else:
		#print("that worked")
		$LevelArea/Sprite.visible = true
		$LevelArea/Sprite2.visible = false
	pass


func _on_LevelArea_area_entered(area):
	
	if area.get_name() == "MainCharArea":
		if not Disabled:
			get_tree().change_scene(worldScene)
	
	pass # Replace with function body.
