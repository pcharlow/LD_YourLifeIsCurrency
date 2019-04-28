extends Node2D


func _ready():
	$Enemy.setPlayer($MainChar)
	$Enemy.initialize($Nav, $Route)