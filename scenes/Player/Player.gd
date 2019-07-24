extends KinematicBody2D

var velocity=Vector2()
export(float) var speed=10
export(float) var friction=20
export(float) var max_speed=500

var shot_available=false

func _ready():
	set_position(Vector2(get_viewport().size.x/2,get_viewport().size.y*0.90))

func applyMovement():
	if Input.is_key_pressed(KEY_W) and not velocity.y<=-max_speed:
		velocity.y-=speed
	if Input.is_key_pressed(KEY_S) and not velocity.y>=max_speed:
		velocity.y+=speed
	if Input.is_key_pressed(KEY_A) and not velocity.x<=-max_speed:
		velocity.x-=speed
	if Input.is_key_pressed(KEY_D) and  not velocity.x>=max_speed:
		velocity.x+=speed

func applyFriction():
	if not (Input.is_key_pressed(KEY_W) or Input.is_key_pressed(KEY_S) or Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_D)):
		velocity-=velocity.normalized()*friction
		if velocity.length()<friction:
			velocity=Vector2(0,0)

func shooting():
	if shot_available and Input.is_key_pressed(KEY_SPACE):
		var projectile_scene=load("res://scenes/PlayerProjectile/PlayerProjectile.tscn")
		var projectile=projectile_scene.instance()
		projectile.set_position(self.position)
		self.owner.add_child(projectile)
		shot_available=false
		get_node("FireRate").start()

func enable_shot():
	shot_available=true
	get_node("FireRate").stop()

func stop_on_screen_edges():
    if position.x<0:
        position.x=0
        velocity.x=0
    if position.y<0:
        position.y=0
        velocity.y=0
    if position.x>1280:
        position.x=1280
        velocity.x=0
    if position.y>720:
        position.y=720
        velocity.y=0

func _process(delta):
	shooting()
	applyMovement()
	applyFriction()
	stop_on_screen_edges()
	move_and_slide(velocity)