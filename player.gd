extends Player

var show_game_over = false

#HUD
onready var sprint_bar = $hud/TextureProgress
onready var game_over = $hud/game_over
#signals
signal im_ded

func _ready():
	camera = find_node("Camera")
#	get_node("../").connect("im_ded", self, "player_ded")
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#HUD da barra de correr
	$hud/TextureProgress.set_max(maxrun)
	$hud/TextureProgress.set_value(run_time)

#Capturar movimento do mouse
func _process(delta):
	
	#Movimento
	move(delta)
	run()
	$hud/TextureProgress.set_value(run_time)
	#Camera
	first_person_camera(delta, null)
	if vel.x != 0:
		$view_bob.play("view_bob")
		$Camera/lamp/lamp_anim.play("lamp_bob")
	else:
		$view_bob.stop()
		$Camera/lamp/lamp_anim.stop()
	
	if show_game_over:
		can_look = false
		game_over.set_visible(true)
		$Camera/lamp.set_visible(false)
		camera.rotation_degrees = lerp(camera.rotation_degrees, Vector3(90,0,0), 0.1)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func on_skull_kill():
	print("Skull Killed")
	show_game_over = true
func on_angel_kill():
	print("Angel Killed")
	show_game_over = true

func _on_reset_pressed():
	emit_signal("im_ded")
	print("Playerpressed")
