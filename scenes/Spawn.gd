extends Node2D

export (int) var rocas = 100000
export (float) var ventana_min = 0.8
export (float) var ventana_max = 1.3

var rock = preload("res://scenes/rocks/Rock.tscn")
var rock_medium = preload("res://scenes/rocks/Rock_medium.tscn")
var rock_small = preload("res://scenes/rocks/Rock_small.tscn")

var ventana_tiempo = true
var spawned = 0
var rng = RandomNumberGenerator.new()

func _physics_process(_delta):
	if (spawned < rocas && ventana_tiempo):
		ventana_tiempo = false
		rng.randomize()
		var cant = int(rng.randi_range(2000, 6000) / 1000)
		spawn(cant)
		timer()

func spawn(cant):
	var iteraciones = int(cant / 2)
	spawned += iteraciones
	for n in iteraciones:
		rng.randomize()
		var xpos = int(rng.randi_range(30000, 459999) / 1000)
		match (cant):
			2:
				var new_rock = rock.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_parent().get_node("RockConteiner").add_child(new_rock)
			3:
				var new_rock = rock_medium.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_parent().get_node("RockConteiner").add_child(new_rock)
			4:
				var new_rock = rock_medium.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_parent().get_node("RockConteiner").add_child(new_rock)
			5:
				var new_rock = rock_small.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_parent().get_node("RockConteiner").add_child(new_rock)
			6:
				var new_rock = rock_small.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_parent().get_node("RockConteiner").add_child(new_rock)
	
func timer():
		rng.randomize()
		var sleep_time = float ( rng.randi_range( (ventana_min * 1000), (ventana_max * 1000) ) / 1000 )
		yield(get_tree().create_timer(sleep_time), "timeout")
		ventana_tiempo = true
