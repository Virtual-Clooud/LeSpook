extends StaticBody
## Script que vai selecionar e dar variedade pras árvores

## Selecionar entre os dois modelos de árvores
onready var mod1 = preload("res://Scenes/tree1.tscn")
onready var mod2 = preload("res://Scenes/tree2.tscn")
var mod
# Dar leve variação de escala pras árvores

func _ready():
	randomize()
	rotation_degrees = Vector3(0, rand_range(90, 0), 0)
	scale = Vector3(rand_range(2, 1), rand_range(1.5, 1), rand_range(2,1))
	var m1i = mod1.instance()
	var m2i = mod2.instance()
	mod = round(rand_range(10,0))
	if mod >= 5:
		add_child(m1i)
	else:
		add_child(m2i)
	
func _physics_process(delta):
	pass
