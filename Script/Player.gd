extends KinematicBody2D

var velocity = Vector2.ZERO

const MAX_SPEED = 800
onready var game = get_node("/root/Game")
onready var net = $NetL.get_child(0)
var direction = false

enum actions {
	MOVE,
	CAPTURE,
	COLLECT
}

var state = actions.MOVE
onready var sprite = $AnimatedSprite

func _physics_process(delta):
	match state:
		actions.MOVE:
			move_player(delta)
		actions.CAPTURE:
			capture_bee()
		actions.COLLECT:
			collect_honey()

func move_player(delta):
	sprite.set_animation("default")
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	velocity = input_vector * MAX_SPEED
	
	if Input.get_action_strength("ui_right"):
		direction = true
	elif Input.get_action_strength("ui_left"):
		direction = false
	
	turn_body(direction)
	
	move_and_collide(velocity * delta)
	
	if Input.is_action_just_pressed("capture"):
		state = actions.CAPTURE
	elif Input.is_action_just_pressed("collect"):
		state = actions.COLLECT

func capture_bee():
	net.disabled = false
	sprite.set_animation("capture")
	$Woosh.play()
	yield(get_tree().create_timer(0.2), "timeout")
	net.disabled = true
	state = actions.MOVE

func collect_honey():
	sprite.set_animation("collect")
	$Honey.play()
	yield(get_tree().create_timer(1.2), "timeout")
	state = actions.MOVE

func turn_body(turn):
	sprite.flip_h = turn
	if turn == false:
		net = $NetL.get_child(0)
	else:
		net = $NetR.get_child(0)

func _on_Hurtbox_area_entered(area):
	if area != get_node("/root/Game/SpawnArea"):
		game.update_hp()
		var owch = [$Ow1,$Ow2,$Ow3,$Ow4]
		owch[randi() % owch.size()].play()
