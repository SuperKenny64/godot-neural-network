extends KinematicBody2D

onready var stats = $Stats
onready var clock = $Timer
onready var brain = $ABrain
onready var sprite = $face

onready var egg = preload("res://pops/Aegg.tscn")

const angular_speed = PI

var foodinrange = 0 # 0,?	#output
var sensfoodX = 0			#output
var sensfoodY = 0			#output
var hungry = 0				#output

var hungermulti = 1			#Input
var metabolism = 1			#Input
var direction = 0 # 1,-1  	#Input
var moving = 0 # 0,1		#Input
var healthpc = 1

func _ready():
	clock.start(1 * metabolism)

func _ini(a):
	$ABrain.a = a

func _process(delta):
	
	self.scale = Vector2(healthpc,healthpc)
	rotation += angular_speed * direction * delta
	var velocity = Vector2.ZERO

	velocity = Vector2.UP.rotated(rotation) * stats.speed * metabolism
	velocity = velocity * delta
	
# warning-ignore:return_value_discarded
	move_and_collide(velocity)
	brain.X = [foodinrange,sensfoodX,sensfoodY,hungry,self.global_position.x,self.global_position.y]

func _on_Sensory_body_entered(body):
	if body.get_name() == "food":
		foodinrange += 0.1
		sensfoodX = body.position.x
		sensfoodY = body.position.y

func _on_Sensory_body_exited(body):
	if body.get_name() == "food":
		foodinrange -= 0.1

func _on_Timer_timeout():
	#process stats
	print(stats.material,stats.symp,stats.life)
	
	if stats.material <= 80 * hungermulti:
		hungry = 1
	if stats.symp >= 90:
		stats.symp -= 2
		Aegg()
	if stats.symp >= 1:
		stats.symp -=1
	if stats.material >= 1:
		stats.material -= 1
	else:
		stats.life -= 5 
	#healthpc = stats.life / 100 #setget """bug""""
	#scale = Vector2(healthpc,healthpc)

func _on_Interaction_body_entered(body):
	body.interaction(self)

func interaction(_ref):
	pass

func Aegg():
	print("egg")
	var a = brain.save() 
	var node = get_parent()
	var child = egg.instance()
	child.global_position = global_position + Vector2(0,48)
	child.a = a
	node.add_child(child)

func _on_ABrain_idea(ARRAY):
	moving = 	ARRAY[3]
	direction = ARRAY[2] 
	
	if ARRAY[0] > 0.5:
		moving = ARRAY[3] * -1
	
	if ARRAY[1] > 0.5:
		direction = ARRAY[2] * -1
