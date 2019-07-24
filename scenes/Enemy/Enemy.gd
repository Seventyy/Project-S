extends Area2D

class_name Enemy

export(float) var hp
export(float) var speed
export(Vector2) var initial_coords
var velocity=Vector2(0,0)

func _ready():
	set_position(initial_coords)

func checkLife():
	if hp<=0:
		get_tree().queue_delete(self)

func _process(delta):
	checkLife()
	pass

func _on_Enemy_area_shape_entered(area_id, area, area_shape, self_shape):
	if area is PlayerProjectile:
		hp-=area.damage
		get_tree().queue_delete(area)
	pass

func shoot():
	var projectile_scene=load("res://scenes/EnemyProjectile/EnemyProjectile.tscn")
	var projectile=projectile_scene.instance()
	projectile.set_position(self.get_position())
	self.owner.add_child(projectile)
	pass
