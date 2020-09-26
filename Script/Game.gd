extends Node2D

var score
var hp
var running = true
var near_honey = false
var collecting = false


func _ready():
	score = 0
	hp = 3
	$ScoreLabel.text = str(score) + ""
	$HealthLabel.text = str(hp) + " HP"
	randomize()

func _process(_delta):
	if Input.is_action_just_pressed("collect") && near_honey && !collecting:
		update_score(50)
		collecting = true
		yield(get_tree().create_timer(1.0), "timeout")
		collecting = false

func update_score(points):
	if running:
		score += points
		$ScoreLabel.text = str(score)
		$BeeKeeper/Points.text = "+" + str(points)
		$BeeKeeper/Points.visible = true
		yield(get_tree().create_timer(1.0), "timeout")
		$BeeKeeper/Points.visible = false

func update_hp():
	if running:
		hp -= 1
		$HealthLabel.text = str(hp) + " HP"
		$BeeKeeper/HP.visible = true
		yield(get_tree().create_timer(1.2), "timeout")
		$BeeKeeper/HP.visible = false
		if hp <= 0:
			game_over()

func is_running():
	return running

func game_over():
	running = false
	$GameOver/End.visible = true
	$GameOver/Info.visible = true
	$GameOver/Button.disabled = false

func _on_SpawnArea_area_entered(_area):
	near_honey = true

func _on_Button_pressed():
	get_tree().change_scene("res://TitleScreen.tscn")

func _on_SpawnArea_area_exited(_area):
	near_honey = false

func _on_Song_finished():
	$Song.stop()
	$Song.play()


func _on_SpawnTimer_timeout():
	$SpawnArea.spawn()
