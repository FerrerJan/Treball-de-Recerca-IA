extends Control

@onready var from = $From
@onready var to = $To
@onready var weight = $Weight
var i = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !from.text.is_valid_int() and !from.text.is_empty():
		from.text = str(from.text.to_int())
	
	if !to.text.is_valid_int() and !to.text.is_empty():
		to.text = str(to.text.to_int())
		
	if !weight.text.is_valid_float() and !weight.text.is_empty():
		weight.text = str(weight.text.to_float())
	
	Global.connections[i] = [from.text.to_int(), to.text.to_int(), weight.text.to_float()]
