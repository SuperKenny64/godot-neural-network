extends StaticBody2D

var a

var agent = load("res://pops/Agent.tscn")

func newborn():
	var node = get_parent()
	var child = agent.instance()
	child._ini(a)
	child.global_position = global_position
	node.add_child(child)

func _on_Timer_timeout():
	newborn()
	self.queue_free()

func interaction(_ref):
	pass
