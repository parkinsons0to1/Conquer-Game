# Sapiens: Game Design Document (GDD) & Dual-Campaign Blueprint

## 1. Vision & Historical Philosophy (Yuval Noah Harari's *Sapiens*)

*Sapiens* explores two revolutionary moments in human history where humanity broke boundaries by daring to explore what was completely unknown:

```
                                  SAPIENS
                                     │
           ┌─────────────────────────┴─────────────────────────┐
           ▼                                                   ▼
     CAMPAIGN A:                                         CAMPAIGN B:
 THE GREAT MIGRATION                                  TERRA INCOGNITA
(50,000 BCE – 1,300 CE)                                   (1492 CE)
• Prehistoric Hunter-Gatherer                       • European Navigator / Explorer
• Sunda to Sahul (Australia)                        • Transatlantic Crossing (Spain to Americas)
• Surviving Ice Age Megafauna                       • 3D Caravel Sailing & Wind Dynamics
• Stone Tool Knapping & Fire                        • The "Empty Map" Cartography System
• Pacific Voyaging Canoes                           • Rations, Scurvy & Mutiny Survival
• Hawaii, Madagascar, New Zealand                   • Landing Expeditions, Outposts & Royal Wealth
```

---

## 2. Campaign A: The Great Migration (Prehistoric Survival)

* **Setting:** 45,000 years ago across Southeast Asia into prehistoric Australia (Sahul) and out into the Pacific.
* **Core Loop:**
  * **Explore:** Strip away the local Fog of War, find caves and freshwater sources.
  * **Harvest:** Chip flint nodes, collect hardwood branches, harvest fibrous sinew.
  * **Craft:** Knap flint blades, make friction fire drills, bind spears.
  * **Hunt & Survive:** Track footprints of giant megafauna (*Diprotodon*, giant flightless *Moa*, predatory *Thylacoleo*).
  * **Expand:** Build ocean-going outrigger voyaging canoes to navigate by constellations to uncharted islands.

---

## 3. Campaign B: Terra Incognita (1492 — Age of Discovery)

* **Setting:** 15th-century Atlantic Ocean, beginning in southern Spain and venturing into the uncharted Western Hemisphere.
* **The "Discovery of Ignorance" Thesis:**
  * Medieval maps filled the world with mythical beasts because mapmakers pretended they knew everything.
  * 15th-century European maps were **blank white sheets** labeled *"Terra Incognita"* (Unknown Lands). This game mechanics reflects that exact historical shift.

### Core Systems & Mechanics:
1. **The "Empty Parchment" Cartography System:**
   * There is no GPS or revealed world map. You start with a blank scroll.
   * As your ship sails past headlands, bays, reefs, and islands, the ink physically sketches the coastline, depth soundings, and safe anchorages in real time.
   * Accurate maps can be charted and sold back in Europe for royal prestige, titles, and funding.
2. **3D Ship Physics & Wind Aerodynamics:**
   * Command an authentic 15th-century **Caravel** (like the *Santa María* or *Niña*).
   * **Square Rigging vs. Lateen Rigging:**
     * Square sails provide maximum speed when running before the wind.
     * Triangular lateen sails allow "tacking" (cutting diagonally against head-winds).
   * **Wave & Swell Physics:** Ocean buoyancy, rogue waves, hull stress, and rudder steering.
3. **Expedition Attrition & Mutiny:**
   * **Supplies:** Fresh water casks, barrels of hardtack biscuit, salt meat, citrus rations.
   * **Scurvy & Thirst:** Prolonged weeks at sea drain crew health.
   * **Morale Clock:** If rations spoil or progress stalls in the open ocean, crew dissent rises. The captain must make hard choices to maintain order.
4. **Landing Expeditions & New World Wealth:**
   * Spotting land, sounding depth, and dropping the heavy iron anchor.
   * Lowering the wooden longboat and rowing ashore to tropical beaches in full third-person 3D.
   * Claiming territory under the royal charter.
   * Discovering valuable commodities: gold veins, tobacco, exotic spices, mahogany.
   * Constructing fortified palisade trading posts (*La Navidad* / *Santo Domingo* style).
   * Filling the ship's hold and sailing back across the Atlantic to enrich your home port and finance grander expeditions.

---

## 4. Sibling Co-op & Input Design

Designed specifically for **1 Physical Gamepad (Xbox) + 1 Smartphone (Sister's Phone)**:

| Feature | Campaign A (Prehistoric) | Campaign B (Age of Sail) |
| :--- | :--- | :--- |
| **Player 1 (Xbox Gamepad)** | **The Hunter:** 3D movement, spear thrusts, dodging, climbing, and campfire building. | **The Helmsman / Captain:** Steers the caravel, commands sails, drops anchor, fires deck swivel guns. |
| **Player 2 (Sister's Smartphone)** | **The Shaman / Tracker:** Phone displays footprint radar, tool crafting, star readings, and inventory. | **The Navigator / Cartographer:** Phone displays the live-drawing parchment map, astrolabe latitude calculations, and ration management. |

---

## 5. Technical Architecture & File Layout

```
sapiens_survival/
├── assets/
│   └── models/
│       ├── spear.glb            # Flint survival spear (Campaign A)
│       ├── campfire.glb         # Stone hearth & embers (Campaign A)
│       ├── caravel.glb          # 15th-century sailing ship (Campaign B)
│       ├── anchor.glb           # Ship anchor & longboat (Campaign B)
│       ├── rock.glb             # Low-poly mineral node
│       └── tree.glb             # Prehistoric & tropical flora
├── scenes/
│   ├── main.tscn                # Main menu & mode selector
│   ├── prehistoric/
│   │   ├── island_world.tscn    # Campaign A 3D wilderness
│   │   └── player.tscn          # Hunter character controller
│   └── age_of_sail/
│       ├── ocean_world.tscn     # Dynamic 3D ocean, wind & wave system
│       ├── caravel_ship.tscn    # Steerable 3D ship physics controller
│       └── landing_shore.tscn   # Caribbean/tropical island landing
├── scripts/
│   ├── player_controller.gd     # 3D hunter movement & vitals
│   ├── ship_controller.gd       # 3D caravel buoyancy, sail trim & rudder physics
│   ├── cartography_map.gd       # Procedural coast drawing / Fog of War
│   └── hud.gd                   # Dynamic vitals / ship status UI
└── tools/
    ├── generate_assets.py       # Blender Python script for Campaign A props
    └── generate_ship.py         # Blender Python script for 3D Caravel & maritime assets
```

---

## 6. Multi-Milestone Roadmap

* [x] **Milestone 1: Prehistoric Foundation (COMPLETED)**
  * 3D Third-person character controller, stamina/hunger HUD, test arena.
  * Headless Blender generator for flint spear, campfire, rocks, and trees.
* [ ] **Milestone 2: Prehistoric Harvesting & Inventory (NEXT)**
  * Chipping flint from rocks, cutting branches from trees, inventory slots.
* [ ] **Milestone 3: Procedural 3D Caravel & Ocean Prototype**
  * Blender script (`generate_ship.py`) modeling 3D wooden caravel hull, masts, and sails.
  * Godot 3D water surface with wind-driven ship sailing physics.
* [ ] **Milestone 4: Prehistoric Megafauna AI**
  * Procedural *Diprotodon* model and herd roaming/fleeing AI.
* [ ] **Milestone 5: The "Terra Incognita" Blank Map System**
  * Dynamic parchment map that draws coastlines as the ship sails.
* [ ] **Milestone 6: Sibling Dual-Controller Bridge**
  * Local Wi-Fi WebSocket bridge enabling the smartphone companion screen.
