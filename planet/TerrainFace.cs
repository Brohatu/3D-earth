using Godot;
using Microsoft.VisualBasic;
using System;

public class TerrainFace
{
	ArrayMesh mesh;
	int resolution;
	Vector3 localUp;
	Vector3 axisA;
	Vector3 axisB;
	
	public TerrainFace(ArrayMesh mesh, int resolution, Vector3 localUp)
	{
		this.mesh = mesh;
		this.resolution = resolution;
		this.localUp = localUp;
		
		axisA = new Vector3(localUp.Y, localUp.Z, localUp.X);
		axisB = localUp.Cross(axisA);
	}
	
	public void ConstructMesh()
	{
		var meshData = new Godot.Collections.Array();
		meshData.Resize((int)Mesh.ArrayType.Max);

		// Array of vertices with size determined by resolution
		Vector3[] vertices = new Vector3[resolution * resolution];

		// Array of 
		int[] triangles = new int[(resolution-1)*(resolution-1)*6];
		int triIndex = 0;

		// Loop through columns
		for (int y = 0; y < resolution; y++)
		{	
			// Loop through rows
			for (int x = 0; x < resolution; x++)
			{
				// Calculate vertex and add it to vertices array
				int i = x + y * resolution;
				Vector2 percent = new Vector2(x, y)  / (resolution - 1);
				Vector3 pointOnUnitCube = localUp + (percent.X-0.5f) * 2 * axisA + (percent.Y - -0.5f) * 2 * axisB;
				vertices[i] = pointOnUnitCube;
				
				// Create triangles within grid of vertices
				if (x != resolution - 1 && y != resolution - 1)
				{
					triangles[triIndex] = i;
					triangles[triIndex+1] = i+resolution+1;
					triangles[triIndex+2] = i+resolution;
					
					triangles[triIndex+3] = i;
					triangles[triIndex+4] = i+1;
					triangles[triIndex+5] = i+resolution+1;

					triIndex += 6;
				}
			}
		}
		
		
		meshData[(int)Mesh.ArrayType.Vertex] = vertices;
		mesh.ClearSurfaces();
		mesh.AddSurfaceFromArrays(Mesh.PrimitiveType.Triangles, meshData);
		
		var m = new MeshInstance3D();
		m.Mesh = mesh;
		//mesh.vertices = vertices;
		//mesh.triangles = triangles;
		//mesh.RecalculateNormals();


	}
	
}
