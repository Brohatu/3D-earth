@tool
extends MeshInstance3D

@export var update = false
#var a = 1
#var b = 2
#var c = a + b


# Called when the node enters the scene tree for the first time.
func _ready():
	gen_mesh()
	
func gen_mesh():
	var mesh_array = ArrayMesh.new()
	var vertices := PackedVector3Array(
		[
			Vector3(0,1,0),
			Vector3(1,1,0),
			Vector3(1,1,1),
			Vector3(0,1,1),
			Vector3(0,0,0),
			Vector3(1,0,0),
			Vector3(1,0,1),
			Vector3(0,0,1),
			
		]
	)
	
	var indices := PackedInt32Array(
		[
			0,1,2,
			0,2,3,
			3,2,7,
			2,6,7,
			2,1,6,
			1,5,6,
			1,4,5,
			1,0,4,
			0,3,7,
			4,0,7,
			6,5,4,
			4,7,6,
		]
	)
	
	
	var uvs = PackedVector2Array(
		[
			Vector2(0,0),
			Vector2(1,0),
			Vector2(1,1),
			Vector2(0,1),
			
			Vector2(0,0),
			Vector2(1,0),
			Vector2(1,1),
			Vector2(0,1)
		]
	)
	
#	var array = []
#	array.resize(Mesh.ARRAY_MAX)
#	array[Mesh.ARRAY_VERTEX] = vertices
#	array[Mesh.ARRAY_INDEX] = indices
#	array[Mesh.ARRAY_TEX_UV] = uvs
#	mesh_array.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,array)
#	mesh = mesh_array
	
	var surface_tool = SurfaceTool.new()
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	for i in range(vertices.size()):
		surface_tool.set_uv(uvs[i])
		surface_tool.add_vertex(vertices[i])
	for i in indices:
		surface_tool.add_index(i)
	surface_tool.generate_normals()
	mesh_array = surface_tool.commit()
	mesh = mesh_array


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if update:
		gen_mesh()
		update = false
