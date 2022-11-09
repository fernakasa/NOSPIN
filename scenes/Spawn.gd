extends Node2D

export (int) var rocas = 300
export (int) var ventana_min = 3
export (int) var ventana_max = 5

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
	print('se crearan: ', iteraciones, " - van: ", spawned, "/", rocas, " rocas")
	for n in iteraciones:
		rng.randomize()
		var xpos = int(rng.randi_range(30000, 459999) / 1000)
		match (cant):
			2:
				print(cant, " - grande")
				var new_rock = rock.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_tree().get_root().add_child(new_rock)
			3:
				print(cant, " - mediana")
				var new_rock = rock_medium.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_tree().get_root().add_child(new_rock)
			4:
				print(cant, " - mediana")
				var new_rock = rock_medium.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_tree().get_root().add_child(new_rock)
			5:
				print(cant, " - chica")
				var new_rock = rock_small.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_tree().get_root().add_child(new_rock)
			6:
				print(cant, " - chica")
				var new_rock = rock_small.instance()
				new_rock.initLocation = Vector2(xpos, -50)
				get_tree().get_root().add_child(new_rock)
	
func timer():
		rng.randomize()
		var sleep_time = float ( rng.randi_range( (ventana_min * 1000), (ventana_max * 1000) ) / 1000 )
		yield(get_tree().create_timer(sleep_time), "timeout")
		ventana_tiempo = true
