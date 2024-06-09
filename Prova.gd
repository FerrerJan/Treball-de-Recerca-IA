extends Node2D

var list := [0, 1, 3]
# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	 # Replace with function body.
	list.insert(len(list) - 2, 2)
	for i in range(100):
		print(list[rng.randi_range(0, len(list) - 1)])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
