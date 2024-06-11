extends Node2D

var list := [0, 1, 3]
# Called when the node enters the scene tree for the first time.
func _ready():
	var rng = RandomNumberGenerator.new()
	 # Replace with function body.
	list.insert(len(list) - 2, 2)
	var enable := false
	for i in range(100):
		if i == 100:
			enable = false
			break
		enable = true
	print(enable)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
