@tool
extends MeshInstance3D

class_name TerrainFace

var mesh_array: ArrayMesh
@export var resolution: int = 10
var localUp: Vector3
var axis_a: Vector3
var axis_b: Vector3
@export var update = false

func _init(mesh_arr:ArrayMesh, res:int, direction:Vector3):
	mesh_array = mesh_arr
	resolution = res
	localUp = direction
	
	axis_a = Vector3(localUp.y, localUp.z, localUp.x)
	axis_b = localUp.cross(axis_a)

func construct_mesh():
	# Array of vertices with size determined by resolution
	var vertices = PackedVector3Array()
	vertices.resize(resolution*resolution)
	var triangles = PackedInt32Array()
	triangles.resize((resolution-1)*(resolution-1)*6)
	var tri_index: int = 0
	
	for y in range(resolution):
		for x in range(resolution):
			var i = x + y * resolution
			var percent:Vector2 = Vector2(x,y)/(resolution-1)
			var point_on_cube:Vector3 = localUp + (percent.x - 0.5) * 2 * axis_a + (percent.y - 0.5) * 2 * axis_b
			vertices[i] = point_on_cube
			
			if(x != resolution - 1 and y != resolution - 1):
				triangles[tri_index] = i
				triangles[tri_index+1] = i+resolution+1
				triangles[tri_index+2] = i+resolution
				
				triangles[tri_index+3] = i
				triangles[tri_index+4] = i+1
				triangles[tri_index+5] = i+resolution+1

				tri_index += 6
	
	var surface_tool = SurfaceTool.new()
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(vertices.size()):
		#surface_tool.set_uv(uvs[i])
		surface_tool.add_vertex(vertices[i])
	for i in triangles:
		surface_tool.add_index(i)
	surface_tool.generate_normals()
	mesh_array = surface_tool.commit()
	mesh = mesh_array






# Called when the node enters the scene tree for the first time.
func _ready():
	construct_mesh()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if update:
		construct_mesh()
		update = false
		

