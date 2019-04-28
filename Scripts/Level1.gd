extends Node2D


func _ready():
	$Nav
	$Enemy.setPlayer($MainChar)
	$Enemy.initialize($Nav, $Route)