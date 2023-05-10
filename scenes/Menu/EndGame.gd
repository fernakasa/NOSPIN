extends Control

func _ready():
	$VBoxContainer/PlayAgainBtn.grab_focus()

func _on_PlayAgainBtn_pressed():
	get_tree().change_scene("res://level/World.tscn")

func _on_ExitBtn_pressed():
	get_tree().change_scene("res://scenes/Menu/Menu.tscn")

func setValores(score, recursos):
	self.visible = true
	$VBoxLabel/HBoxScore/Score.text = str(score)
	$VBoxLabel/HBoxRecursos/Recursos.text = str(recursos)
	$VBoxLabel/HBoxTotal/Total.text = str(score * recursos)
