extends KinematicBody2D

var mood = ["default","angry"]

export var speed = 200
var direction = Vector2.ZERO
onready var game

enum action {
	WANDER,
	FOLLOW
}

var near_player = false
var state = action.WANDER

func _ready():
	$Sprite.animation = mood[randi() % mood.size()]
	$MoveTimer.start()
	if get_tree().get_current_scene().get_name() == "Game":
		game = get_tree().get_current_scene()

func _on_Visibility_screen_exited():
	queue_free()

func _physics_process(delta):
	if direction.x < 0:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true
	match state:
		action.WANDER:
			wander(delta)
		action.FOLLOW:
			pass

func wander(delta):
	if $MoveTimer.is_stopped():
		direction = Vector2(rand_range(-1280,1280),rand_range(-720,720)).normalized()
		$MoveTimer.wait_time = rand_range(0.3,10)
		$MoveTimer.start()
	else:
		move_and_slide(direction * 2000 * delta)

func captured():
	game.update_score(15)
	queue_free()

func _on_Hurtbox_area_entered(_area):
	captured()
