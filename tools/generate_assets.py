import bpy
import math
import os

def clear_scene():
    """Clear all objects and materials from the current Blender scene."""
    bpy.ops.wm.read_factory_settings(use_empty=True)

def create_material(name, color_rgba, roughness=0.7, emission_rgba=None, emission_strength=0.0):
    """Create a basic Principled BSDF material."""
    mat = bpy.data.materials.new(name=name)
    mat.use_nodes = True
    nodes = mat.node_tree.nodes
    bsdf = nodes.get("Principled BSDF")
    if bsdf:
        bsdf.inputs["Base Color"].default_value = color_rgba
        if "Roughness" in bsdf.inputs:
            bsdf.inputs["Roughness"].default_value = roughness
        if emission_rgba and "Emission Color" in bsdf.inputs:
            bsdf.inputs["Emission Color"].default_value = emission_rgba
            if "Emission Strength" in bsdf.inputs:
                bsdf.inputs["Emission Strength"].default_value = emission_strength
    return mat

def assign_material(obj, mat):
    if obj.data.materials:
        obj.data.materials[0] = mat
    else:
        obj.data.materials.append(mat)

def build_flint_spear(output_path):
    clear_scene()
    
    # Materials
    wood_mat = create_material("WoodShaft", (0.32, 0.19, 0.09, 1.0), roughness=0.85)
    flint_mat = create_material("FlintStone", (0.12, 0.12, 0.14, 1.0), roughness=0.35)
    sinew_mat = create_material("SinewBinding", (0.55, 0.48, 0.35, 1.0), roughness=0.9)
    
    # 1. Wooden Shaft
    bpy.ops.mesh.primitive_cylinder_add(
        vertices=8,
        radius=0.025,
        depth=1.8,
        location=(0, 0, 0.9)
    )
    shaft = bpy.context.active_object
    shaft.name = "SpearShaft"
    assign_material(shaft, wood_mat)
    
    # 2. Sinew Binding at head
    bpy.ops.mesh.primitive_cylinder_add(
        vertices=8,
        radius=0.035,
        depth=0.15,
        location=(0, 0, 1.75)
    )
    binding = bpy.context.active_object
    binding.name = "SinewBinding"
    assign_material(binding, sinew_mat)
    
    # 3. Chipped Flint Blade
    bpy.ops.mesh.primitive_cone_add(
        vertices=5,
        radius1=0.07,
        radius2=0.0,
        depth=0.35,
        location=(0, 0, 1.95)
    )
    blade = bpy.context.active_object
    blade.name = "FlintBlade"
    blade.scale = (0.4, 1.0, 1.0) # Flatten like a real knapped blade
    bpy.ops.object.transform_apply(scale=True)
    assign_material(blade, flint_mat)
    
    # Join all into one object
    bpy.ops.object.select_all(action='SELECT')
    bpy.context.view_layer.objects.active = shaft
    bpy.ops.object.join()
    shaft.name = "PrehistoricFlintSpear"
    
    # Export to GLB
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bpy.ops.export_scene.gltf(filepath=output_path, export_format='GLB')
    print(f"Exported Spear to {output_path}")

def build_stone_campfire(output_path):
    clear_scene()
    
    # Materials
    stone_mat = create_material("Stone", (0.35, 0.35, 0.38, 1.0), roughness=0.9)
    charred_wood_mat = create_material("CharredWood", (0.08, 0.06, 0.05, 1.0), roughness=0.95)
    ember_mat = create_material("Embers", (1.0, 0.3, 0.05, 1.0), emission_rgba=(1.0, 0.35, 0.05, 1.0), emission_strength=4.0)
    
    # 1. Circle of Stones
    num_stones = 9
    radius = 0.65
    for i in range(num_stones):
        angle = (2 * math.pi / num_stones) * i
        x = radius * math.cos(angle)
        y = radius * math.sin(angle)
        scale_var = 0.8 + ((i % 3) * 0.15)
        
        bpy.ops.mesh.primitive_cube_add(
            size=0.25,
            location=(x, y, 0.1)
        )
        stone = bpy.context.active_object
        stone.name = f"Stone_{i}"
        stone.rotation_euler = (0.2 * (i % 2), 0.15 * (i % 3), angle)
        stone.scale = (scale_var, scale_var * 0.9, scale_var * 0.8)
        assign_material(stone, stone_mat)
    
    # 2. Crossed Logs
    num_logs = 4
    for i in range(num_logs):
        log_angle = (math.pi / num_logs) * i + 0.3
        bpy.ops.mesh.primitive_cylinder_add(
            vertices=6,
            radius=0.05,
            depth=0.7,
            location=(0, 0, 0.1 + (i * 0.03))
        )
        log = bpy.context.active_object
        log.name = f"Log_{i}"
        log.rotation_euler = (math.pi / 2, 0.15 * (i % 2 - 1), log_angle)
        assign_material(log, charred_wood_mat)
        
    # 3. Glowing Embers in Center
    bpy.ops.mesh.primitive_cylinder_add(
        vertices=8,
        radius=0.28,
        depth=0.08,
        location=(0, 0, 0.04)
    )
    embers = bpy.context.active_object
    embers.name = "Embers"
    assign_material(embers, ember_mat)
    
    # Join into one model
    bpy.ops.object.select_all(action='SELECT')
    bpy.context.view_layer.objects.active = embers
    bpy.ops.object.join()
    embers.name = "Campfire"
    
    # Export to GLB
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bpy.ops.export_scene.gltf(filepath=output_path, export_format='GLB')
    print(f"Exported Campfire to {output_path}")

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    models_dir = os.path.join(base_dir, "assets", "models")
    
    spear_path = os.path.join(models_dir, "spear.glb")
    campfire_path = os.path.join(models_dir, "campfire.glb")
    
    build_flint_spear(spear_path)
    build_stone_campfire(campfire_path)
    print("All 3D procedural assets generated successfully!")

def build_rock(output_path):
    clear_scene()
    stone_mat = create_material("RockStone", (0.3, 0.3, 0.32, 1.0), roughness=0.95)
    bpy.ops.mesh.primitive_ico_sphere_add(subdivisions=2, radius=0.9, location=(0, 0, 0.7))
    rock = bpy.context.active_object
    rock.name = "PrehistoricRock"
    rock.scale = (1.2, 0.85, 0.75)
    bpy.ops.object.transform_apply(scale=True)
    assign_material(rock, stone_mat)
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bpy.ops.export_scene.gltf(filepath=output_path, export_format='GLB')
    print(f"Exported Rock to {output_path}")

def build_primitive_tree(output_path):
    clear_scene()
    bark_mat = create_material("TreeBark", (0.25, 0.15, 0.08, 1.0), roughness=0.9)
    foliage_mat = create_material("Foliage", (0.12, 0.35, 0.12, 1.0), roughness=0.7)
    
    # Trunk
    bpy.ops.mesh.primitive_cylinder_add(vertices=7, radius=0.18, depth=2.2, location=(0, 0, 1.1))
    trunk = bpy.context.active_object
    assign_material(trunk, bark_mat)
    
    # Foliage tiers (3 stacked cones)
    cones = []
    for i in range(3):
        bpy.ops.mesh.primitive_cone_add(vertices=6, radius1=1.2 - (i * 0.25), depth=1.4, location=(0, 0, 2.0 + (i * 0.8)))
        cone = bpy.context.active_object
        assign_material(cone, foliage_mat)
        cones.append(cone)
        
    bpy.ops.object.select_all(action='SELECT')
    bpy.context.view_layer.objects.active = trunk
    bpy.ops.object.join()
    trunk.name = "PrimitiveTree"
    
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    bpy.ops.export_scene.gltf(filepath=output_path, export_format='GLB')
    print(f"Exported Tree to {output_path}")

if __name__ == "__main__":
    base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    models_dir = os.path.join(base_dir, "assets", "models")
    build_rock(os.path.join(models_dir, "rock.glb"))
    build_primitive_tree(os.path.join(models_dir, "tree.glb"))
