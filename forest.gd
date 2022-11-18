extends Spatial
onready var player = $player
onready var parent = get_node("..")
signal reset
func _ready():
	self.connect("im_ded", player, "player_ded")
func player_ded():
	print("PLAYER DIED")
	emit_signal("reset")
	parent.connect("reset", self, "reset_forest")
