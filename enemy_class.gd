extends KinematicBody
class_name Enemy
func chase(prey, speed):
	var prey_pos = Vector2(to_global(prey.get_translation()).x, 
	to_global(prey.get_translation()).z)
	var pos = Vector2(to_global(get_translation()).x,
	to_global(get_translation()).z)
	var direction = (prey_pos - pos).normalized()
	direction = Vector3(direction.x, 0, direction.y)
	move_and_slide(direction*speed, Vector3.UP)
func wander(speed):
	move_and_slide(Vector3(rand_range(0,0.5)* speed, 0, rand_range(0,0.5)* speed))

