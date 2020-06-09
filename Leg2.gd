extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 2
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func easeInOutCubic(t) :
	return -(cos(PI * abs(sin(t))) - 1) ;



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	t+=delta
	rotation_degrees = -45 + 45 * easeInOutCubic(7*t)
	pass
