extends KinematicBody

onready var player = get_node("../player")
onready var lamp = get_node("../player/Camera/lamp")
export var speed = 1
var player_pos
var pos
var direction
var can_flee = false

func _ready():
	lamp.connect("fuckoff", self, "on_lamp")
func _physics_process(delta):
	player_pos = Vector2(to_global(player.get_translation()).x,
	to_global(player.get_translation()).z)
	pos = Vector2(to_global(get_translation()).x,
	to_global(get_translation()).z)
	direction = (player_pos - pos).normalized()
	$MeshInstance.look_at(player.get_translation(), Vector3.UP)
	direction = Vector3(direction.x, 0, direction.y)
	move_and_slide(direction*speed, Vector3.UP)


func _on_light_area_area_entered(area):
	can_flee = true
func on_lamp():
	translation = Vector3(100,100,100)
