extends KinematicBody
# stats
var curHP
export var maxHP : int = 10
export var oil : int = 15

# physics
var can_run = true
var maxrun = 100
var run_time
export var maxSpeed : float = 10.0
var moveSpeed : float = 5.0
export var jumpForce : float = 5.0
export var gravity : float = 12.0
# cam look
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
export var lookSensitivity : float = 10.0
# vectors
var vel : Vector3 = Vector3()
var mouseDelta : Vector2 = Vector2()

# components
onready var camera : Camera = get_node("Camera")
onready var lamp : Sprite3D = get_node("lamp")


func _ready():
	Engine.set_target_fps(25)
	run_time = maxrun
	curHP = maxHP
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$hud/TextureProgress.set_max(maxrun)
	$hud/TextureProgress.set_value(run_time)
func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
func _process(delta):
	#Movimento
	if Input.is_action_pressed("run") and can_run:
		moveSpeed = maxSpeed * 1.7
		run_time -= 2
	if run_time <= 1:
		can_run = false
		moveSpeed = maxSpeed
	if run_time <= (maxrun/ 4):
		can_run = true
	if (run_time < 0):
		run_time = 0
	if (run_time < maxrun):
		run_time += 1
	$hud/TextureProgress.set_value(run_time)
	var input = Vector2()
	if Input.is_action_pressed("frente"):
		input.y -= 1
	if Input.is_action_pressed("tras"):
		input.y += 1
	if Input.is_action_pressed("direita"):
		input.x += 1
	if Input.is_action_pressed("esquerda"):
		input.x -= 1
	if input.x != 0 or input.y != 0:
		if moveSpeed <= maxSpeed:
			moveSpeed = lerp(moveSpeed, maxSpeed, 0.1)
		camera.fov = lerp(camera.fov,92, 0.1)
	if input.x == 0 and input.y == 0:
		camera.fov = lerp(camera.fov,90, 0.05)
		if moveSpeed > 0:
			moveSpeed = lerp(moveSpeed, 0, 0.05)
	input = input.normalized()
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	var relativeDir = (forward * input.y + right * input.x)
	# set the velocity
	var speedx = relativeDir.x * moveSpeed
	var speedz = relativeDir.z * moveSpeed
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	# apply gravity
	vel.y -= gravity * delta
	# move the player
	move_and_slide(vel, Vector3.UP)
	#Camera
	# rotate the camera along the x axis
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	# clamp camera x rotation axis
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, 
	minLookAngle, maxLookAngle)
	# rotate the player along their y-axis
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	# reset the mouseDelta vector
	mouseDelta = Vector2()
