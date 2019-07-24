extends Area2D

class_name PlayerProjectile

export(Vector2) var velocity=Vector2(0,-1000)
export(float) var damage=5

func _process(delta):
	set_position(get_position()+velocity*delta)
	if get_position().y<0:
		queue_free()
	pass