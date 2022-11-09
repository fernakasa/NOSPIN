extends KinematicBody2D

export var initLocation = Vector2()
export (int) var movespeed = 400
export (int) var bullet_speed = 600
export (float) var bullet_cadence = 0.2
export (int) var bullet_power = 20


var bullet = preload("res://scenes/bullet/Bullet.tscn")
var shooting = false

func _ready():
	self.position = initLocation

func _physics_process(_delta):
	var motion = Vector2()
	
	if Input.is_action_pressed("up"):
		motion.y -= 1
	
	if Input.is_action_pressed("down"):
		motion.y += 1
	
	if Input.is_action_pressed("left"):
		motion.x -= 1
	
	if Input.is_action_pressed("rigth"):
		motion.x += 1
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if Input.is_action_pressed("lbm") and !shooting:
		fire()


func fire():
	shooting = true
	var bullet_instance = bullet.instance()
	bullet_instance.initLocation = Vector2(0, -30) + get_global_position()
	bullet_instance.bullet_speed = bullet_speed
	bullet_instance.bullet_power = bullet_power
	get_tree().get_root().add_child(bullet_instance)
	$Sound_Shoot.playing = true
	yield(get_tree().create_timer(bullet_cadence), "timeout")
	shooting = false
	
