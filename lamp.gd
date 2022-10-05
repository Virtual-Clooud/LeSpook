extends Sprite3D

onready var l1 = $OmniLight
onready var l2 = $OmniLight2
export var l1range = 14
export var l2range = 3
export var maxlight = 40
var can_light = true
func _ready():
	l1.omni_range = l1range
	l2.omni_range = l1range	
func _physics_process(delta):
	if Input.is_action_just_pressed("lamp") and can_light == true and l1.omni_range == l1range:
		$Tween.interpolate_property(l1, "omni_range",
		l1.omni_range, maxlight, 1.3,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
		can_light = false
	if l1.omni_range == maxlight:
		can_light = true
		$Tween.interpolate_property(l1, "omni_range",
		l1.omni_range, l1range, 2,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
