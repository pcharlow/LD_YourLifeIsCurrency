extends Node2D

# Declare member variables here. Examples:
onready var player = $MainCharBody
onready var playerText = $MainCharBody/TestLabel
onready var meleeHitbox = $MainCharBody/Melee/MeleeCollider
onready var aoeHitbox = $MainCharBody/AOE/AoeCollider


const UP = 0
const LEFT = 1
const DOWN = 2
const RIGHT =3

const Projectile = preload("res://Projectile.tscn")

#char variables
var gameover : bool = false

var maxHP : int = 100
var HP : int = 100
var speed : int = 200
var movement = Vector2()

#potentially unneeded
var direction : int = 0
var horMoving : bool = false
var vertMoving : bool = true
var movingDiagonal : bool = false

#unlocked abilites
var unlockedMelee : bool = true
var unlockedRanged : bool = false
var unlockedDodge : bool = false
var unlockedGrapple : bool = false
var unlockedSpeed : bool = false
var unlockedAOE : bool = false

#cooldowns
var canMove : bool = true
var isMoving : bool = false

var canMelee : bool = true
var isMeleeing : bool = false

var canDodge : bool = true
var isDodging : bool = false

var canGrapple : bool = true
var isGrapple : bool = false

var canSpeed : bool = true
var isSpeeding : bool = false

var canAOE : bool = true

var canRanged : bool = true

#timer creation
var canAttackTimer = null
var attackCooldown = .15

var canDodgeTimer = null
var dodgeCooldown = 1

var canAOETimer = null
var AOECooldown = 1

var canGrappleTimer = null
var grappleCooldown = 1

var canSpeedTimer = null
var speedCooldown = 1
var speedingTimer = null
var speedingTime = 1

var canRangedTimer = null
var rangedCooldown = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#create timers
	canAttackTimer = Timer.new()
	canAttackTimer.set_one_shot(true)
	canAttackTimer.set_wait_time(attackCooldown)
	canAttackTimer.connect("timeout", self, "_enable_Action",["canMelee"])
	add_child(canAttackTimer)	
	#canAttackTimer.start()
	
	canDodgeTimer = Timer.new()
	canDodgeTimer.set_one_shot(true)
	canDodgeTimer.set_wait_time(dodgeCooldown)
	canDodgeTimer.connect("timeout", self,"_enable_Action",["canDodge"])
	add_child(canDodgeTimer)	
	#canDodgeTimer.start()
	
	canAOETimer = Timer.new()
	canAOETimer.set_one_shot(true)
	canAOETimer.set_wait_time(AOECooldown)
	canAOETimer.connect("timeout", self,"_enable_Action",["canAOE"])
	add_child(canAOETimer)	
	
	canGrappleTimer = Timer.new()
	canGrappleTimer.set_one_shot(true)
	canGrappleTimer.set_wait_time(grappleCooldown)
	canGrappleTimer.connect("timeout", self,"_enable_Action",["canGrapple"])
	add_child(canGrappleTimer)	
	
	canRangedTimer = Timer.new()
	canRangedTimer.set_one_shot(true)
	canRangedTimer.set_wait_time(rangedCooldown)
	canRangedTimer.connect("timeout", self,"_enable_Action",["canRanged"])
	add_child(canRangedTimer)	
	
	canSpeedTimer = Timer.new()
	canSpeedTimer.set_one_shot(true)
	canSpeedTimer.set_wait_time(speedCooldown)
	canSpeedTimer.connect("timeout", self,"_enable_Action",["canSpeed"])
	add_child(canSpeedTimer)	
	
	speedingTimer = Timer.new()
	speedingTimer.set_one_shot(true)
	speedingTimer.set_wait_time(speedingTime)
	speedingTimer.connect("timeout", self,"_enable_Action",["isSpeeding"])
	add_child(speedingTimer)	
	
	
	pass # Replace with function body.





#determines the current input
func _GetInput():
	
	movement = Vector2()
	isMoving = Input.is_action_pressed("mainChar_up") or Input.is_action_pressed("mainChar_down") or Input.is_action_pressed("mainChar_left") or Input.is_action_pressed("mainChar_right")
	#vertMoving = Input.is_action_pressed("mainChar_up") or Input.is_action_pressed("mainChar_down")
	#horMoving = Input.is_action_pressed("mainChar_right") or Input.is_action_pressed("mainChar_left")
	
	if Input.is_action_pressed("mainChar_up"):
		movement.y -= 1
	if Input.is_action_pressed("mainChar_down"):
		movement.y += 1
	if Input.is_action_pressed("mainChar_left"):
		movement.x -= 1
	if Input.is_action_pressed("mainChar_right"):
		movement.x += 1
	if Input.is_action_pressed("mainChar_meleeAttack"):
		_PerformMeleeAttack()
	if Input.is_action_pressed("mainChar_dodge"):
		_PerformDodge()
	if Input.is_action_pressed("mainChar_speed"):
		_PerformSpeed()
	if Input.is_action_pressed("mainChar_AOE"):
		_PerformAOE()
	if Input.is_action_pressed("mainChar_rangeAttack"):
		_PerformRanged()
		
		
		
	movement = movement.normalized() * speed
	
	
	pass







# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	
	_GetInput()
	player.look_at(get_global_mouse_position())
	playerText.text = str(HP) + "/" + str(maxHP)
	
	if isSpeeding:
		speed = 600
	elif not isSpeeding:
		speed = 200
	
	
	if canMove:
			
		if isMoving:
			
			 player.move_and_slide(movement)
		
		#if vertMoving and horMoving:
		#	movingDiagonal = true
		
	
	
	pass






func _PerformDodge():
	
	if canDodge:
		canDodge = false
		isDodging = true
		
		canDodgeTimer.start()
	pass







#functions for melee and melee cooldown
func _PerformMeleeAttack():
	
	if canMelee:
		canMelee = false
		isMeleeing = true
		meleeHitbox.disabled = false
		$MainCharBody/Melee/MeleeCollider/Temp.visible = true
		
		
		yield(get_tree().create_timer(.25), "timeout")
		
		meleeHitbox.disabled = true
		isMeleeing = false
		$MainCharBody/Melee/MeleeCollider/Temp.visible = false
		#code for melee (expand hit box or call new object with collision)
		
		
		canAttackTimer.start()
	pass






#cast the AOE attack
func _PerformAOE():
	if HP > 10:
		if canAOE:
			canAOE = false
			HP -= 10
			aoeHitbox.disabled = false
			$MainCharBody/AOE/AoeCollider/Sprite.visible = true
		
		
			yield(get_tree().create_timer(.40), "timeout")
		
			aoeHitbox.disabled = true

			$MainCharBody/AOE/AoeCollider/Sprite.visible = false
			#code for melee (expand hit box or call new object with collision)
		
		
			canAOETimer.start()
	pass






#Enables the Speed powerup
func _PerformSpeed():
	if HP > 8:
		if canSpeed:
				HP -= 8
				isSpeeding = true
				canSpeed = false
				speedingTimer.start()
	pass







func _PerformRanged():
	
	
	var ranged = Projectile.instance()
	ranged.pos = position
	ranged.dir = direction
	get_parent().add_child(ranged)
	
	
	pass
	
	
	
	
	
#Used by timers to reset actions for use	
func _enable_Action(action):
	
	if action == "canDodge":
		canDodge = true
		
	if action == "canMelee":
		canMelee = true
		
	if action == "canAOE":
		canAOE = true
		
	if action == "canGrapple":
		canGrapple = true
		
	if action == "canRanged":
		canRanged = true
		
	if action == "canSpeed":
		canSpeed = true
		
	if action == "isSpeeding":
		isSpeeding = false
		canSpeedTimer.start()		
		
	pass