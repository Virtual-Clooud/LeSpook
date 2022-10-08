extends Sprite3D

onready var rad = $OmniLight
onready var direct = $SpotLight
export var l1range = 14
export var l2range = 25
export var maxlight = 40
var can_light = true

signal fuckoff
func _ready():
	rad.omni_range = l1range
	direct.spot_range = l2range
func _physics_process(delta):
	if Input.is_action_just_pressed("lamp") and can_light == true and rad.omni_range == l1range:
		$Tween.interpolate_property(rad, "omni_range",
		rad.omni_range, maxlight, 1.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		can_light = false
		emit_signal("fuckoff")
	if rad.omni_range == maxlight:
		can_light = true
		$Tween.interpolate_property(rad, "omni_range",
		rad.omni_range, l1range, 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
