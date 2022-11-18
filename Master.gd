extends Spatial

onready var forest = preload("res://forest.tscn")
onready var lvl2
onready var lvl3

func _ready():
	pass
func reset_forest():
	remove_child($level)
	var forest_ins = forest.instance()
	add_child(forest_ins)
