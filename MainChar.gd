extends Node2D

# Declare member variables here. Examples:
onready var player = $MainCharBody
onready var playerText = $MainCharBody/TestLabel
onready var meleeHitbox = $MainCharBody/Melee/MeleeCollider
onready var MainHitbox = $MainCharBody/MainCharCollider
onready var aoeHitbox = $MainCharBody/AoeArea/AoeCollider
onready var aoeAnim = $MainCharBody/BloodAOE
onready var HPBar = $"CanvasLayer/HUD"
onready var aud = get_parent().get_node("AudioNode")


const UP = 0
const LEFT = 1
const DOWN = 2
const RIGHT =3

const Projectile = preload("res://Projectile.tscn")

#char variables
var gameover : bool = false


var HP : int = 100
var speed : int = 200
var movement = Vector2()

var AltarText = ""
var interacting : bool = false
var canInteract : bool = false

#0 = maxhp boost
#1 = spawn enemy
#2 = shortcut

var interactionType : int = 0

#potentially unneeded
var direction : int = 0
var horMoving : bool = false
var vertMoving : bool = true
var movingDiagonal : bool = false


#cooldowns
var canMove : bool = true
var isMoving : bool = false

var canMelee : bool = true
var isMeleeing : bool = false

var canDodge : bool = true
#var isDodging : bool = false

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

#onready var pack = get_node("HPPackBody")

# Called when the node enters the scene tree for the first time.
func _ready():
	#Initialize global
	Player_Vars.Player = self
	HP = Player_Vars.maxHP
	get_viewport().audio_listener_enable_2d = true
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
	
	if Player_Vars.unlockedRanged:
		$MainCharBody/Line2D.visible = true
	
	pass # Replace with function body.

func _raiseHealth(sender, amount):
	if HP < Player_Vars.maxHP - amount:
		HP += amount
		var packSound = aud.get_node("PackPickup")
		packSound.play()
		#$AudioNode/PackPickup.play()
		#$MainCharBody/PackPickup.play()
		sender.queue_free()
	elif HP > Player_Vars.maxHP - amount and HP != Player_Vars.maxHP:
		HP = Player_Vars.maxHP
		var packSound = aud.get_node("PackPickup")
		packSound.play()
		#$AudioNode/PackPickup.play()
		#$MainCharBody/PackPickup.play()
		sender.queue_free()
	pass



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
		if Player_Vars.unlockedDodge:
			_PerformDodge()
	if Input.is_action_pressed("mainChar_speed"):
		if Player_Vars.unlockedSpeed:
			_PerformSpeed()
	if Input.is_action_pressed("mainChar_AOE"):
		if Player_Vars.unlockedAOE:
			_PerformAOE()
	if Input.is_action_pressed("mainChar_rangeAttack"):
		if Player_Vars.unlockedRanged:
			_PerformRanged()
	if Input.is_action_pressed("mainChar_grapple"):
		if Player_Vars.unlockedGrapple:
			_PerformGrapple()
	if Input.is_action_pressed("mainChar_interact"):
		_PerformInteraction()
	if Input.is_action_pressed("mainChar_reset"):
		get_tree().reload_current_scene()
		
	movement = movement.normalized() * speed
	
	
	pass







# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):

	
	
	HPBar.maxHPValue = Player_Vars.maxHP
	HPBar.HPValue = HP
	#if not isDodging:
	
	
	if not interacting:
		player.look_at(get_global_mouse_position())
		_GetInput()
		
		
		if not Player_Vars.isDodging:
		
			if isSpeeding:
				speed = 600
			elif not isSpeeding:
				speed = 200
	
	
			if canMove:
			
				#if isMoving:
			
				#var coll = player.move_and_slide(movement)
					_CheckAOECollsiion()
					var coll = player.move_and_collide(movement * delta)
					if coll:
						#print(coll.collider.name)
						if coll.collider.name == "HPPackBody":
							if HP < Player_Vars.maxHP - 20:
								HP += 20
								coll.collider.queue_free()
							elif HP > Player_Vars.maxHP - 20 and HP != Player_Vars.maxHP:
								HP = Player_Vars.maxHP
								coll.collider.queue_free()

						if coll.collider.name == "Break1":
							coll.collider.get_parent().hitTarget(1)
						if coll.collider.name == "Break2":
							coll.collider.get_parent().hitTarget(2)
						if coll.collider.name == "Break3":
							coll.collider.get_parent().hitTarget(3)
						if coll.collider.name == "Break4":
							coll.collider.get_parent().hitTarget(4)
							
					
					else:
						playerText.text = ""
		#if vertMoving and horMoving:
		#	movingDiagonal = true
		
	
	#var coll = aoeHitbox.collis
	
	
	pass


onready var AOEColl = $MainCharBody/AOE
func _CheckAOECollsiion():
	
	#if AOEColl.is_collding():
	#	print("test")
	
	pass

func _PerformDodge():
	if HP > 5:
		
		if canDodge:
			HP -= 5
			canDodge = false
			Player_Vars.isDodging = true
			
			#player.translate(player.transform.x.normalized() * speed)
			#var newDir = get_global_mouse_position() - player.position.normalized()
			#player.linear_velocity = newDir * speed
			
			var mouse_position = get_global_mouse_position()
			var projectile_direction = (player.global_position - mouse_position).normalized()
			#player.position -= projectile_direction * (100)
			var WarpSound = aud.get_node("Warp")
			WarpSound.play()
			player.set_collision_mask_bit(3, false)#collision_mask(4).
			player.set_collision_layer_bit(3, false)
			player.move_and_slide((projectile_direction * (7000)) * -1)
			Player_Vars.isDodging = false
			player.set_collision_mask_bit(3, true)
			player.set_collision_layer_bit(3, true)
			canDodgeTimer.start()
	pass





func _PerformGrapple():
	
	
	
	pass





#functions for melee and melee cooldown
func _PerformMeleeAttack():
	
	if canMelee:
		canMelee = false
		isMeleeing = true
		meleeHitbox.disabled = false
		$MainCharBody/Melee/MeleeCollider/Temp.visible = true

		var MeleeSound = aud.get_node("Melee")
		MeleeSound.play()
		
		yield(get_tree().create_timer(.4), "timeout")
		
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
			aoeAnim.frame = 0
			aoeHitbox.disabled = false
			aoeAnim.visible = true
			aoeAnim.connect("animation_finished", self, "_DisableAOE")
			aoeAnim.play("default")
		
	pass

func _DisableAOE():
	
	aoeAnim.visible = false
	aoeHitbox.disabled = true
	#canAOETimer.start()
	
	yield(get_tree().create_timer(1), "timeout")
	canAOE = true
	
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
	if HP > 3:
		
		if canRanged:
			HP -= 3
			canRanged = false
			var ranged = Projectile.instance()
			ranged.pos = player.position
			ranged.dir = player.rotation_degrees
			player.get_parent().add_child(ranged)
			var ShotSound = aud.get_node("BloodShot")
			ShotSound.play()
			canRangedTimer.start()
	
	pass
	
	
	
func _PerformInteraction():
	if not interacting:
		if canInteract:
			interacting = true
			$CanvasLayer/HUD/PanelContainer.visible = true
			$CanvasLayer/HUD/PanelContainer/GridContainer/VBoxContainer/QuestionLabel.text = AltarText
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

func _on_AoeArea_body_entered(body):
	#hitTarget(1)
	if body.get_name() == "Break1":
		body.get_parent().hitTarget(1)
	if body.get_name() == "Break2":
		body.get_parent().hitTarget(2)
	if body.get_name() == "Break3":
		body.get_parent().hitTarget(3)
	if body.get_name() == "Break4":
		body.get_parent().hitTarget(4)
	#print(body.get_name())
	
	pass # Replace with function body.
