extends KinematicBody

onready var nav = get_parent()

export var speed = 200
export var state = 0 #idle, chase, attack
var distance
var pos
onready var player = get_node("../player/hit_area")

func _physics_process(delta):
	distance = Vector2(to_global(player.get_translation()).z, 
	to_global(player.get_translation()).x)
	pos = Vector2(to_global(get_translation()).z, to_global(get_translation()).x)
	pos.distance_to(distance)
	print(distance)
	#Pegar a posição do jogador
	#Se chegar em certa proximidade ativar modo de perseguição
#	if distance <= 15:
#		state = 1
#	match state:
#		0:
#			pass
#		1:
#			look_at(player.get_translation(), Vector3.UP)
#		2:
#			print("Two are better than one!")
#
	pass
