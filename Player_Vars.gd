extends Node

var maxHP : int = 100

var unlockedMelee : bool = true
var unlockedSpeed : bool = true
var unlockedRanged : bool = true
var unlockedDodge : bool = true
var unlockedGrapple : bool = false
var unlockedAOE : bool = true

var isDodging : bool = false

# To be initialized by MainChar and only to be used to obtain values out of it
var Player