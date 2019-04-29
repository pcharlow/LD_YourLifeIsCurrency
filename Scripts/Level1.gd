extends Node2D


func _ready():
	$Brute.setPlayer($MainChar)
	$Brute.initialize($Nav, $Route)