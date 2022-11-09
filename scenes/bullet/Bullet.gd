extends RigidBody2D

export var initLocation = Vector2()
export (int) var bullet_speed
export (int) var bullet_power

func _ready():
	position = initLocation
	apply_impulse(Vector2(), Vector2(0, -bullet_speed))


func _on_Bullet_body_entered(body):
	if !body.is_in_group("player"):
		queue_free()
