extends Node

var maxHP : int = 100

var unlockedMelee : bool = true
var unlockedSpeed : bool = true
var unlockedRanged : bool = false
var unlockedDodge : bool = false
var unlockedGrapple : bool = false
var unlockedAOE : bool = true

var isDodging : bool = false

# To be initialized by MainChar and only to be used to obtain values out of it
var Player