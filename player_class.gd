extends KinematicBody
class_name Player


var curHP : int
export var maxHP : int = 10
# Movment
export var maxSpeed : float = 5.0
var moveSpeed : float = 5.0
export var jumpForce : float = 5.0
var can_run = true
export var maxrun : int = 100
var run_time = maxrun
export var gravity : float = 12.0
var vel : Vector3 = Vector3()
# First Person Camera
var minLookAngle : float = -90.0
var maxLookAngle : float = 90.0
export var lookSensitivity : float = 10.0
var can_look : bool = true
var mouseDelta : Vector2 = Vector2()
onready var camera : Camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
func reset():
	emit_signal("im_ded")
	print("Playerpressed")
func move(delta):
	var input = Vector2()
	if Input.is_action_pressed("frente"):
		input.y -= 1
	if Input.is_action_pressed("tras"):
		input.y += 1
	if Input.is_action_pressed("direita"):
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, -2, 0.2)
		input.x += 1
	if Input.is_action_pressed("esquerda"):
		camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 2, 0.2)
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
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	# apply gravity
	vel.y -= gravity * delta
	# move the player
	move_and_slide(vel, Vector3.UP)
	camera.rotation_degrees.z = lerp(camera.rotation_degrees.z, 0, 0.07)
func first_person_camera(delta, sensitivity):
	if can_look:
		# rotate the camera along the x axis
		camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
		# clamp camera x rotation axis
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, 
		minLookAngle, maxLookAngle)
		# rotate the player along their y-axis
		rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
		# reset the mouseDelta vector
		mouseDelta = Vector2()
func run():
	if Input.is_action_pressed("run") and can_run:
		moveSpeed = maxSpeed * 1.7
		run_time -= 2
		$view_bob.set_speed_scale(1)
		$Camera/lamp/lamp_anim.set_speed_scale(1)
	else:
		moveSpeed = maxSpeed
		$view_bob.set_speed_scale(0.5)
		$Camera/lamp/lamp_anim.set_speed_scale(0.5)
	
	if run_time <= 1:
		can_run = false
		moveSpeed = maxSpeed
	if run_time <= (maxrun/ 4):
		can_run = true
	if (run_time < 0):
		run_time = 0
	if (run_time < maxrun):
		run_time += 1
	
