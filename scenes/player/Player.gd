extends KinematicBody2D

export var initLocation = Vector2()
export (int) var dificultad = 1
export (int) var recursos = 0
export (int) var score = 0
export (int) var salud = 500
export (int) var vidas = 3
export (int) var movespeed = 400
export (int) var bullet_speed = 600
export (float) var bullet_cadence = 0.2
export (int) var bullet_power = 25

var bullet = preload("res://scenes/bullet/Bullet.tscn")
var pauseMenu = preload("res://scenes/Menu/Pausa.tscn")
var shooting = false
var invulnerable = false
var pauseGame = false

onready var SPAWN = get_parent().get_node("Spawn")
onready var HUD = get_parent().get_node("Hud")
onready var ENDGAME = get_parent().get_node("EndGame")
onready var HUD_Naves = get_parent().get_node("Hud/Naves")
onready var HUD_Vida = get_parent().get_node("Hud/Vida")
onready var HUD_Recursos = get_parent().get_node("Hud/Recursos")
onready var HUD_Score = get_parent().get_node("Hud/Score")

func _ready():
	self.position = initLocation
	self.HUD_Vida.value = salud

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
		
	if Input.is_action_pressed("pause"):
		pause()
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	
	if Input.is_action_pressed("lbm") and !shooting:
		fire()

func pause():
	get_tree().paused = true
	get_parent().get_node("Pausa").visible = true

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
	
func setDamage(damage):
	if !invulnerable:
		$AnimationPlayer.play("damage")
		salud -= damage
		self.HUD_Vida.value = salud
		if (salud <= 0):
			$Sprite.visible = false
			die()

func setScore(cant):
	self.score += int(cant)
	self.HUD_Score.text = str(self.score)	

func setRecurses(cant):
	self.recursos += int(cant)
	self.HUD_Recursos.text = str(self.recursos)
	if(recursos > (500 * dificultad)):
		dificultad += 1
		if (SPAWN.ventana_min > 0.2): 
			SPAWN.ventana_min -= 0.1
		if (SPAWN.ventana_max > 0.4): 
			SPAWN.ventana_max -= 0.1

func die():
	self.shooting = true
	self.invulnerable = true
	if (vidas > 0):
		self.HUD.startCounter(3)
		yield(get_tree().create_timer(3), "timeout")
		restart()
	else:
		endGame()
		
func restart():
	self.vidas -= 1
	self.HUD_Naves.text = str(vidas)
	self.salud = 500
	self.HUD_Vida.value = salud
	self.position = initLocation
	$Sprite.visible = true
	self.shooting = false
	$AnimationPlayer.play("respawnd")
	yield(get_tree().create_timer(2), "timeout")
	self.invulnerable = false
	
func endGame():
	emit_signal("queue_rocks")
	get_tree().paused = true
	ENDGAME.setValores(self.score, self.recursos)
