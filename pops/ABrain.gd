extends Node
#X[0] = foodinrange
#X[2] = sensfoodX
#X[3] = sensfoodY
#X[4] = hungry

var X = [1,1,1,1,1,1] setget think
var Y = [1,1,1,1] 

signal idea(ARRAY)

var NeuralNetwork = preload("res://lib/Neural Network/Brain.gd")

export var input_nodes: int 
export var hidden_nodes: int
export var output_nodes: int
export var mutation_rate: float

export var inputs: Array
export var inptuts: Array
export var targets: Array

var a

onready var neural_network = NeuralNetwork.new(input_nodes, 
											   hidden_nodes, 
											   output_nodes)

func _ready():
	if a != null:
		neural_network.duplicate()
		neural_network.mutation_rate = 0.1
		neural_network.mutate()

func think(array):
	Y = neural_network.predict(array)
								#mutation rate too high!?!
	#neural_network.duplicate()
	#neural_network.mutation_rate = mutation_rate
	#neural_network.mutate()
	emit_signal("idea",Y)
#	neural_network.train(array,Y)

func save():
	var save_dict = {
		"filename" : get_filename(),
		"input_nodes" : input_nodes, 
		"hidden_nodes" : hidden_nodes, 
		"output_nodes" : output_nodes, 
		"mutation_rate" : mutation_rate,
		"weights_ih": neural_network.weights_ih.to_array(), # input -> hidden
		"weights_ho": neural_network.weights_ih.to_array(), # hidden -> output
		"bias_h": neural_network.weights_ih.to_array(),
		"bias_o": neural_network.weights_ih.to_array()
		
		
	}
	return save_dict


