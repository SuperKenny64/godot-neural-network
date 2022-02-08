extends Area2D

export var rate = 1.1

const food = preload("res://testworld/food.tscn")
onready var area = $ReferenceRect

func _ready():
	$Timer.start(5/rate)

func _on_Timer_timeout():
	var child = food.instance()
	var node = get_parent()
	child.position = area.rect_position + Vector2(randf()*area.rect_size.x,randf()*area.rect_size.y)
	node.add_child(child)
