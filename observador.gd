extends Enemy

onready var nav = get_parent()
onready var player = get_node("../player")

export var speed = 5
export var state = 0

var distance
var pos
var player_pos
var direction
var look_player
var color = Color(0.309804, 0.909804, 0.956863)
var can_kill = false

signal angel_kill

onready var animation = $animation
func _ready():
	self.connect("angel_kill", player, "on_angel_kill")
	look_player = to_global(player.get_translation())
	$SpotLight.light_color = Color(0.309804, 0.909804, 0.956863)
func _physics_process(delta):
	animation.play("get")
	look_player = lerp(look_player, player.get_translation(), 0.025)
	#Pegar a posição do jogador
	#Se chegar em certa proximidade ativar modo de perseguição

	
	match state:
		0:
			wander(speed)
			$SpotLight.set_rotation_degrees(lerp($SpotLight.get_rotation_degrees(), 
			Vector3(90,0,0), 0.02))
			$mesh.set_visible(false)
			#Mover em direção aleatória
		1:
			#Perseuir jogador e avermelhar luz caso jogador ficar no centro
			chase(player,speed)
			
			$SpotLight.look_at(look_player, Vector3.UP)
			$mesh.look_at(player.get_translation(), Vector3.UP)
			$kill.look_at(look_player, Vector3.UP)
			$mesh.set_visible(true)
	#Definir posições com to_global()
	player_pos = Vector2(to_global(player.get_translation()).x, 
	to_global(player.get_translation()).z)
	pos = Vector2(to_global(get_translation()).x, 
	to_global(get_translation()).z)
	#Definir posição e direção até o jogador
	distance = pos.distance_to(player_pos)
	
	
	if distance <= 12:
		state = 1
	elif distance >= 20:
		state = 0
	if can_kill:
		$SpotLight.set_color(lerp($SpotLight.get_color(), 
		Color(0.913725, 0.313726, 0.133333), 0.02))
	else:
		$SpotLight.set_color(lerp($SpotLight.get_color(), 
		Color(0.309804, 0.909804, 0.956863), 0.01))
	
	if $SpotLight.light_color.r >= 0.85:
		
		emit_signal("angel_kill")

func _on_death_area_area_entered(area):
	if area.is_in_group("player"):
		can_kill = true
		
	else:
		can_kill = false

func _on_death_area_area_exited(area):
	can_kill = false

#Timer para parar perseguição
func _on_Timer_timeout():
	state = 0
	print("IM STOP")
