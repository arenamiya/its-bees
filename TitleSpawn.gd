extends Area2D

const bumble = preload("res://Characters/BumbleBee.tscn")
const drag = preload("res://Characters/DragBee.tscn")
const honey = preload("res://Characters/HoneyBee.tscn")
const knight = preload("res://Characters/KnightBee.tscn")
const queen = preload("res://Characters/QueenBee.tscn")
const baybee = preload("res://Characters/Baybee.tscn")
const blue = preload("res://Characters/BlueBee.tscn")
const hornet = preload("res://Characters/Hornet.tscn")
const quatemalan = preload("res://Characters/Quatemalan.tscn")
const shy = preload("res://Characters/ShyBee.tscn")
const wasp = preload("res://Characters/Wasp.tscn")
const yello = preload("res://Characters/YelloJacket.tscn")
const zombee = preload("res://Characters/Zombee.tscn")

var bees = [bumble,drag,honey,knight,queen,baybee,blue,hornet,quatemalan,shy,wasp,yello,zombee]
var next_spawn
onready var game = get_tree().get_current_scene()

func _ready():
	randomize()
	for n in range(8):
		var bee = bees[randi() % bees.size()].instance()
		bee.position.x = $Spawner.position.x
		bee.position.y = $Spawner.position.y
		game.call_deferred("add_child",bee)

