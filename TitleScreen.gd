extends Control

func _ready():
	randomize()

func _on_Song_finished():
	$Song.stop()
	$Song.play()

func _on_Button_pressed():
	print(get_tree().change_scene("res://Game.tscn"))
