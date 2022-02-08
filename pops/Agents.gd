extends YSort


func _ready():
	pass # Replace with function body.

func _input(_event):
	if Input.is_action_pressed("ui_accept"):
		save_game()

func save_game():
	var save_game = File.new()
	save_game.open("user://neurals.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for i in save_nodes:
		var node_data = i.call("save");
		save_game.store_line(to_json(node_data))
	save_game.close()
	print("saved")
