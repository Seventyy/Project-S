extends Area2D

class_name EnemyProjectile

export(Vector2) var velocity=Vector2(0,500)
export(float) var damage=1

func _process(delta):
	set_position(get_position()+velocity*delta)
	if get_position().y>get_viewport().size.y:
		queue_free()
	pass