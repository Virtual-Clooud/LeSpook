extends Control

var parent
var next_instance
func _ready():
	
	parent = get_node("../")
	print(parent)
func _on_Quit_pressed():
	get_tree().queue_free()


func _on_Start_pressed():
	pass
	add_child_below_node(parent, next_instance)
	get_node("..").queue_free()
