extends Spatial

onready var tree = preload("res://Scenes/tree.tscn")
export var ntrees = 0
var xrange
var zrange
func spawn_tree():
	for x in range(ntrees):
		xrange = rand_range(150, -150)
		zrange = rand_range(150, -120)
		var treeinst = tree.instance()
		treeinst.translation = Vector3(xrange, 0, zrange)
		add_child(treeinst)
		
		
func _ready():
	randomize()
	spawn_tree()

