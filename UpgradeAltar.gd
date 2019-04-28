extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var AltarText = "This Altar Requires %50 of your HP to obtain"

#5=ranged 6=dodge 7=speed 8 = aoe
export var AltarType = 5
var ability = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	
	pass


func _on_UpgradeArea_area_entered(area):
	if area.get_name() == "MainCharArea":
		$Label.visible = true
		area.get_parent().get_parent().canInteract = true

		if AltarType == 5:
			area.get_parent().get_parent().AltarText = "This Altar Requires 50 HP to obtain a new ability, Continue?"
			area.get_parent().get_parent().interactionType = 5
		if AltarType == 6:
			area.get_parent().get_parent().AltarText = "This Altar Requires 60 HP to obtain a new ability, Continue?"
			area.get_parent().get_parent().interactionType = 6
		if AltarType == 7:
			area.get_parent().get_parent().AltarText = "This Altar Requires 75 HP to obtain a new ability, Continue?"
			area.get_parent().get_parent().interactionType = 7
		if AltarType == 8:
			area.get_parent().get_parent().AltarText = "This Altar Requires 90 HP to obtain a new ability, Continue?"
			area.get_parent().get_parent().interactionType = 8
	pass # Replace with function body.


func _on_UpgradeArea_area_exited(area):
	if area.get_name() == "MainCharArea":
		$Label.visible = false
	
	pass # Replace with function body.
