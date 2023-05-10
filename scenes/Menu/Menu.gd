extends Control

func _ready():
	$VBoxContainer/StartBtn.grab_focus()

func _on_StartBtn_pressed():
	get_tree().change_scene("res://level/World.tscn")

func _on_ExitBtn_pressed():
	get_tree().quit()
