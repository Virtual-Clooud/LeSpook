extends Enemy

onready var lamp = get_node("../player/Camera/lamp")
onready var player = get_node("../player")
var player_node = find_node("player")


export var speed = 1
var can_flee = false
var player_pos
var pos
var direction
onready var animation = $AnimationPlayer

signal skull_kill



func _ready():
#	lamp.connect("fuckoff", self, "on_lamp")
	self.connect("skull_kill", player, "on_skull_kill")
	animation.play("pulse")
func _physics_process(delta):
	
	#Mover até o jogador
	chase(player,speed)
	$MeshInstance.look_at(player.get_translation(), Vector3.UP)

func _on_light_area_area_entered(area):
	can_flee = true
func on_lamp():
	translation = Vector3(translation.x,
	0,(translation.z  - 30))
	can_flee = false


func _on_kill_area_area_entered(area):
	if area.is_in_group("player"):
		emit_signal("skull_kill")
		print("Skull Killd")
