extends RigidBody2D

export var initLocation = Vector2()
export (int) var damage = 125
export (float) var initVelocity = 80.0
export (int) var vida = 60
var rock_small = preload("res://scenes/rocks/Rock_small.tscn")
var rng = RandomNumberGenerator.new()

onready var player = get_tree().get_root().get_node("World/Player")

func _ready():
	self.position = initLocation
	rng.randomize()
	var new_xvelocity = float( (rng.randi_range(10000,150000) -80000) / 1000 )
	var new_yvelocity = initVelocity + float( rng.randi_range(10000,70000) / 1000 )
	apply_impulse(Vector2(), Vector2(new_xvelocity, new_yvelocity))
	rng.randomize()
	var new_angle = float( (rng.randi_range(10000,30000) -20000) / 1000 )
	angular_velocity = new_angle
	angular_damp = 0

func _on_Rock_medium_body_entered(body):
	if body.is_in_group("bordes"):
		queue_free()
	
	if body.is_in_group("bullet"):
		vida -= body.bullet_power
		self.player.setScore(int(vida * body.bullet_power / 5))
		if(vida <= 0):
			self.player.setRecurses(5)
			rng.randomize()
			var change = rng.randi_range(0, 10)
			if( change > 0.45 ):
				var new_rock = rock_small.instance()
				new_rock.initLocation = Vector2(15, 0) + get_global_position()
				get_tree().get_root().call_deferred("add_child",new_rock)
				var new_rock2 = rock_small.instance()
				new_rock2.initLocation = Vector2(-15, 0) + get_global_position()
				get_tree().get_root().call_deferred("add_child",new_rock2)
			$Sound_Explosion.playing = true
			queue_free()
		$Sound_Damage.playing = true

	if body.is_in_group("player"):
		body.setDamage(damage)
