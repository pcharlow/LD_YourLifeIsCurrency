extends "res://Scripts/Detector.gd"

# Classes that inherit this are capable of navigating through the map

export var threshold : float = 5 # stop threshold

var possible = [] # All possible points the character may go to (Obtained from the derivative class)
var NavNode # A Navigation2D node (Obtained from the derivative class)
var index : int = -1 # The current point being used from possible
var path = [] # The points the character must go to on the way to their destination
var destination : Vector2 = Vector2() # The destination of the character

var timer : Timer = Timer.new() # Timer for how long to stay at a point

func _ready():
	timer.connect("timeout", self, "_on_timer_timeout")
	
	# Node must be set to true when navNode2D and possible points are set
	set_process(false)
	
func _process(delta):
	navigate()

func initialize(navigation2Dnode, node2Dpoints):
	NavNode = navigation2Dnode
	possible = node2Dpoints.get_children()
	makePath()
	set_process(true)
	
func makePath() -> void:
	# Pick the next point in the array of points inside the array
	index += 1
	if index == possible.size():
		index = 0
	# Make an optimized path to the point from the current location
	path = NavNode.get_simple_path(global_position, possible[index].global_position, true)
	
func navigate() -> void:
	# Obtain the distance to the next destination in the path
	var distance = position.distance_to(path[0])
	destination = path[0]
	
	if distance > threshold:
		move()
	else:
		updatePath()
	
func move() -> void:
	look_at(destination)
	# Directional vector of where to go multiplied by speed
	velocity = (destination - position).normalized() * WALK_SPEED * speed
	# If stuck, Recalculate
	if is_on_wall():
		makePath()
	move_and_slide(velocity)
	
func updatePath() -> void:
	# If the path has one last value in the array, start the timer
	if path.size() == 1:
		if timer.is_stopped():
			timer.start()
	else:
		path.remove(0)
	
func _on_timer_timeout() -> void:
	makePath()