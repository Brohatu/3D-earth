/*using Godot;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

public partial class Planet : MeshInstance3D
{
    [Range(2,256)]
    public int resolution = 10;

    [Export]
    bool update = false;

    TerrainFace[] terrainFaces;
    //MeshFilter[] meshFilters;
    


    public override void _Ready()
    {
        Initialise();
        GenerateMesh();
    }

    public override void _Process(double delta)
    {
        if (update)
        {
            GenerateMesh();
            update = false;
        }
        //base._Process(delta);
    }

    void Initialise()
    {
        if (meshFilters == null || meshFilters.Length == 0)
        {
            meshFilters = new MeshFilter[6];
        }
        terrainFaces = new TerrainFace[6];
        Vector3[] directions = { Vector3.Up, Vector3.Down, Vector3.Left, Vector3.Right, Vector3.Forward, Vector3.Back };


        for (int i = 0; i < 6; i++)
        {   
            if (meshFilters[i] == null)
            {
                Node3D meshObj = new Node3D(/*"mesh"*//*);
                //meshObj.Transform = transform;

                meshObj.AddComponent<MeshRenderer>();
                meshFilters[i] = meshObj.AddComponent<meshFilters>();
                meshFilters[i].sharedMesh = new Mesh();
            }
            
            
            terrainFaces[i] = new TerrainFace(meshFilters[i].sharedMesh, resolution, directions[i]);
        }
    }


    

    void GenerateMesh()
    {
        foreach (TerrainFace face in terrainFaces)
        {
            face.ConstructMesh();
        }
    }
}*/
