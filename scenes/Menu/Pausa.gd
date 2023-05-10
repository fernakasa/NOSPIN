extends Control

func _ready():
	$VBoxContainer/Resume.grab_focus()

func _on_Resume_pressed():
	print('click')
	get_tree().paused = false
	self.visible = false

func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://scenes/Menu/Menu.tscn")
