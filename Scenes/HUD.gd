extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var pb = $"HP Bar"
onready var lb = $"HP Bar/HP Text"

var maxHPValue : int = 100
var HPValue : int = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pb.max_value = maxHPValue
	pb.value = HPValue
	
	lb.text = str(HPValue) + "/" + str(maxHPValue)
	
	
	pass


onready var SCLocation = get_parent().get_parent().get_parent().get_node("Shortcut Exit")

func _on_btnYes_pressed():
	var player = get_parent().get_parent()
	
	if player.interactionType == 0:
		if player.HP > 50:
			player.HP-=50
			player.maxHP +=10	
			$PanelContainer.visible = false
			player.interacting = false
		else:
			$PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = "Not Enough HP"
			yield(get_tree().create_timer(2.5), "timeout")
			$PanelContainer.visible = false
			player.interacting = false
	elif player.interactionType == 1:
		if player.HP > 10:
			player.HP -= 10
			$PanelContainer.visible = false
			player.interacting = false
			
			#SPAWN ENEMY
			
		else:
			$PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = "Not Enough HP"
			yield(get_tree().create_timer(2.5), "timeout")
			$PanelContainer.visible = false
			player.interacting = false
		
		
	elif player.interactionType == 2:
		if player.HP > 75:
			player.HP -= 75
			$PanelContainer.visible = false
			player.interacting = false
			player.player.global_position = SCLocation.global_position
		else:
			$PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = "Not Enough HP"
			yield(get_tree().create_timer(2.5), "timeout")
			$PanelContainer.visible = false
			player.interacting = false
			
			
			
			
	elif player.interactionType == 5:
		if player.HP > 50:
			player.HP -= 50
			$PanelContainer.visible = false
			player.interacting = false
			Player_Vars.unlockedRanged = true
		else:
			$PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = "Not Enough HP"
			yield(get_tree().create_timer(2.5), "timeout")
			$PanelContainer.visible = false
			player.interacting = false
	elif player.interactionType == 6:
		if player.HP > 60:
			player.HP -= 60
			$PanelContainer.visible = false
			player.interacting = false
			Player_Vars.unlockedDodge = true
		else:
			$PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = "Not Enough HP"
			yield(get_tree().create_timer(2.5), "timeout")
			$PanelContainer.visible = false
			player.interacting = false
	pass # Replace with function body.


func _on_btnNo_pressed():

	$PanelContainer.visible = false
	get_parent().get_parent().interacting = false
	
	pass # Replace with function body.
