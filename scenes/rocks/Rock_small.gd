extends RigidBody2D

export var initLocation = Vector2()
export (float) var initVelocity = 100.0
export (int) var vida = 25

var rng = RandomNumberGenerator.new()

func _ready():
	self.position = initLocation
	rng.randomize()
	var new_xvelocity = float( (rng.randi_range(10000,150000) -80000) / 1000 )
	var new_yvelocity = initVelocity + float( rng.randi_range(10000,90000) / 1000 )
	apply_impulse(Vector2(), Vector2(new_xvelocity, new_yvelocity))
	rng.randomize()
	var new_angle = float( (rng.randi_range(10000,30000) -20000) / 1000 )
	angular_velocity = new_angle
	angular_damp = 0

func _on_Rock_small_body_entered(body):
	if body.is_in_group("bordes"):
		queue_free()
	
	if body.is_in_group("bullet"):
		vida -= body.bullet_power
		if(vida <= 0):
			$Sound_Explosion.playing = true
			queue_free()
		$Sound_Damage.playing = true
