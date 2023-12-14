extends MeshInstance3D

var num_horizontal_segments: int = 10
var num_vertical_segments: int = 10


func gen_mesh():
	# UV sphere
	for h in num_horizontal_segments:
		var angle1: float = (h + 1) * PI / (num_horizontal_segments + 1)
		
		for v in num_vertical_segments:
			var angle2: float = v * TAU / num_vertical_segments
			
			var x: float = sin(angle1) * cos(angle2)
			var y: float = cos(angle1)
			var z: float = sin(angle1) * sin(angle2)
			var point_on_sphere: Vector3 = Vector3(x,y,z)



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
