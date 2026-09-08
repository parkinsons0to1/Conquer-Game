# Conquer Game (Sapiens: The Great Crossing 🏹🔥)

> **Core Concept & Campaigns:**
> * **Campaign A:** Hunter-gatherer Homo sapiens tribe conquering the world (the game finishes when you conquer Hawaii, New Zealand, and Madagascar; locked in the map until you conquer everywhere else).
> * **Campaign B:** European navigator conquering the western world / transatlantic exploration.
> * *Check [DESIGN_NOTES.md](DESIGN_NOTES.md) for the full Game Design Document (GDD) and roadmap.*

---

An open-world 3D prehistoric survival and conquest game built with **Godot 4.7** and procedural 3D assets generated via **Blender 5.2 Python (`bpy`)**.

Inspired by Yuval Noah Harari's *Sapiens*, this game traces humanity's prehistoric expansion across uncharted continents, surviving Ice Age megafauna, discovering fire and stone tools, and eventually crafting ocean-going voyaging canoes to reach the farthest corners of the Earth.

---

## 🎮 Quick Start & How to Play

### Option 1: Direct Launch (Terminal)
```bash
./run_game.sh
```
*(or run `godot --path .`)*

### Option 2: Inside the Godot Editor
1. Open **Godot Engine** (`/Applications/Godot.app`).
2. Double-click **Conquer Game** from your project list (or click **Import** and select `project.godot`).
3. Press **F5** (or the Play button at the top right).

---

## 🕹️ Controls

| Action | Keyboard & Mouse | Xbox Gamepad |
| :--- | :--- | :--- |
| **Move** | `W`, `A`, `S`, `D` | **Left Stick** |
| **Orbit Camera** | Move Mouse | **Right Stick** |
| **Sprint** | Hold `Shift` | **Left Stick Click** / `LB` |
| **Jump** | `Space` | **A Button** |
| **Attack / Spear Thrust** | `Left Click` | **Right Trigger (`RT`)** / `RB` |
| **Toggle Mouse Cursor** | `Esc` | - |

---

## 📁 Project Architecture

```
Conquer Game/
├── icon.svg                     # Custom prehistoric emblem icon
├── project.godot                # Godot 4 configuration & rendering settings
├── run_game.sh                  # One-click game launcher script
├── README.md                    # Project documentation & controls
├── DESIGN_NOTES.md              # Deep Game Design Document (GDD) & roadmap
├── assets/
│   └── models/                  # Procedural 3D models exported from Blender
│       ├── spear.glb            # Flint-tipped survival spear
│       ├── campfire.glb         # Stone campfire with glowing embers
│       ├── rock.glb             # Low-poly boulder
│       └── tree.glb             # Primitive prehistoric tree
├── scenes/
│   ├── main.tscn                # 3D world, environment, day/night lighting, terrain
│   └── player.tscn              # 3D Player with third-person camera & HUD
├── scripts/
│   ├── player_controller.gd     # Kinematic movement, sprint, jump, attack, vitals
│   ├── hud.gd                   # Real-time UI updating health, stamina, hunger bars
│   └── world.gd                 # Dynamic sun orbit & time progression
└── tools/
    └── generate_assets.py       # Headless Blender Python script (procedural 3D modeling)
```

---

## 🛠️ Procedural 3D Asset Pipeline

All 3D assets in this project are generated mathematically via Python code inside Blender. You don't have to sculpt by hand:

To regenerate or build new 3D assets:
```bash
blender -b -P tools/generate_assets.py
```

This generates `.glb` files into `assets/models/` which Godot automatically imports on launch.
