extends Control

func _ready():
	pass # Replace with function body.

func _process(_delta):
	$Counter.text = str(int($Timer.time_left))

func startCounter(number):
	$Respawnd.visible = true
	$Counter.visible = true
	$Timer.start(number)

func endCounter():
	$Respawnd.visible = false
	$Counter.visible = false

func _on_Timer_timeout():
	endCounter()
