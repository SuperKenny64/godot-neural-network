extends Node

onready var food = preload("res://testworld/food.tscn")

export var life = 100 setget kill
export var material = 100
export var symp = 50
export var parsy = 50
export var speed = 100

func _ready():
	pass # Replace with function body.

func kill(value):
	life = value
	if value <= 0:
		var child = food.instance()
		var node = get_parent()
		## buggy ?
		child.position = node.position
		node.get_parent().add_child(child)
		node.queue_free()
