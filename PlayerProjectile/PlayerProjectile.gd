extends Area2D

export(Vector2) var velocity=Vector2(0,-1000)
export(float) var damage

func _process(delta):
	set_position(get_position()+velocity*delta)
	if get_position().y<0:
		queue_free()
	pass