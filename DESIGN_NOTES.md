# Sapiens: Game Design Document (GDD) & Multi-Platform Architecture

## 1. Vision & Historical Philosophy (Yuval Noah Harari's *Sapiens*)

*Sapiens* explores monumental epochs in human history where humanity broke biological and geographical boundaries by daring to explore what was completely unknown:

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
• Pacific Voyaging Outrigger Canoes                 • Rations, Scurvy & Mutiny Survival
• Raider War-Canoes & Coastal Piracy                • NPC Pirate Fleets & High-Seas Plunder
• Bone-Dial Sonar & Far-Sight Tubes                 • Brass Astrolabe Radar & Spyglass Tubes
```

---

## 2. Platform Strategy & Technology Stack

* **Primary Engine:** Godot Engine 4.7.x (Forward+ / Metal renderer on macOS).
* **3D Art & Asset Pipeline:** **Blender 5.2+ (Heavy Focus)**
  * Procedural Python-driven generators (`tools/generate_*.py`) for rapid geometric prototyping.
  * Low-poly stylized and high-fidelity PBR assets exported as `.glb` (GLTF binary) with optimized LODs and collision meshes.
  * Custom 3D assets: Ships, war-canoes, pirate crews, cargo chests, spyglasses, bone dials, campfires, megafauna, and palisades.
* **Target Platforms:**
  * **PC:** macOS (Apple Silicon native via Metal — **current development platform**) and Windows (DirectX 12 / Vulkan).
  * **Consoles:** Xbox Series X/S and PlayStation 5 (via future console export toolchains).
* **Input Support:**
  * Full Keyboard + Mouse controls (with mouse capture camera orbit).
  * Native Gamepad support (Xbox Wireless Controller, DualSense / DualShock 4, Nintendo Switch Pro Controller).

---

## 3. Core Game Modes: Single-Player & Online Multiplayer Rivalry

### 3.1 Single-Player Campaign (Narrative & Immersive Survival)
The player embarks on an epic solo odyssey through human evolution, balancing personal survival (vitals, shelter, warmth) with grand strategic milestones (migrating tribes, charting oceans, founding settlements). Full cinematic immersion, dynamic story arcs, and reactive AI factions.

### 3.2 Online Multiplayer: "The Land Rush" (Conquering Race)
A competitive cross-platform multiplayer mode (2–8 players per session) where friends and rivals drop into the same vast uncharted archipelago or continent to compete for territorial dominance.

* **The Core Race:** Who can explore, claim, fortify, and exploit the land the fastest and the most?
* **Win Conditions & Scoring Metrics:**
  1. **Territory Conquest:** Planting tribal totems (Campaign A) or Royal Charters / Watchtowers (Campaign B) to claim geographical zones. The player controlling >50% of the land or holding the most hexes when time expires wins.
  2. **Economic Supremacy:** Accumulating the largest stockpile of high-tier cargo (gold bullion, sacred obsidian, rare spices, mahogany) delivered safely to base.
  3. **Speed Milestones:** First player to construct an ocean-going Caravel/Voyaging Catamaran, first to discover the "Hidden Sacred Island," or first to conquer the Grand Pirate Bastion.
* **PvPvE Friction & Rivalry:**
  * **Border Clashes:** Players can raid each other's outposts, sabotage crop patches, or burn down enemy palisades.
  * **Pirate Weaponization:** Players can bribe NPC Pirate Chiefs or send false smoke/flare signals to redirect NPC pirate raiders toward a rival's cargo convoy!
  * **Naval / Coastal Skirmishes:** Outrun or broadside rival ships to sink them and dredge up their floating cargo crates.

---

## 4. NPC Pirates, Cargo Risk & Retribution System

Transporting cargo is the lifeblood of wealth and progress, but it carries perilous risks.

```
┌─────────────────┐       Laden with Cargo       ┌─────────────────┐
│ Player Gathers  │ ───────────────────────────> │ Threat Meter    │
│ Valuable Cargo  │                              │ Spikes (Heat)   │
└─────────────────┘                              └────────┬────────┘
                                                          │ Ambushed!
                                                          ▼
┌─────────────────┐       Retribution Quest      ┌─────────────────┐
│ Reclaim Cargo + │ <─────────────────────────── │ NPC Pirates     │
│ Bonus Plunder   │    Assault Pirate Bastion    │ Raid & Steer    │
└─────────────────┘                              │ Loot to Hideout │
                                                 └─────────────────┘
```

### 4.1 Cargo Mechanics & The "Piracy Heat" Meter
* **Cargo Types:**
  * *Campaign A:* Bundles of raw obsidian, megafauna furs, preserved salted fish, sacred ochre stones, carved ancestor statues.
  * *Campaign B:* Chests of minted Spanish gold, tobacco bales, cinnamon/nutmeg crates, silver ingots, iron ship nails.
* **Weight & Encumbrance:** Heavily laden vessels or characters move slower and suffer increased handling drag.
* **Piracy Heat:** The greater the monetary or sacred value of the cargo aboard, the higher the invisible "Heat" meter rises. High Heat spawns NPC pirate squads seeking plunder.

### 4.2 Ambush & Combat Encounters
* **Campaign A:** Savage coastal sea-raiders in agile outrigger war-canoes emerge from mangrove coves, hurling fire-hardened javelins and boarding with bone war-clubs.
* **Campaign B:** Black-sailed pirate sloops and brigantines cross the horizon under the Jolly Roger, firing chain-shot to snap your masts, ramming your hull, and boarding with cutlasses.

### 4.3 The Retribution & Revenge Loop
* If pirates defeat you or breach your cargo hold, they do **not** vaporize your items into thin air.
* The pirate crew steals the cargo, loads it onto their lead flagship, and sails it back to their **Fortified Pirate Bastion / Cove**.
* A **Retribution Quest** is automatically generated:
  * *"Revenge for the Stolen Gold / Sacred Bones"*
  * The player respawns at their base/camp. The pirate hideout is marked with a threatening skull icon on the map.
  * The player can regroup, craft superior spears or arm swivel cannons, gather allies (in multiplayer), and storm the pirate stronghold.
  * **Reward:** Reclaiming 100% of the lost cargo PLUS the pirate captain’s accumulated treasury, unique weapon blueprints, and captive navigators.

---

## 5. The "Ancient Sonar" Radar & Far-Sight Tubes

Instead of an anachronistic modern GPS or green phosphor CRT screen, we adapt the submarine sonar sweep concept (circular dial, sweeping hand, red blip contacts) into historically grounded, visually stunning tools:

### 5.1 Campaign A: The "Shadow-Dial Bone Radar & Far-Sight Reed Tube"
* **The "Shadow-Dial" (Ancient Sonar Compass):**
  * **Aesthetic:** A circular disk carved from mammoth ivory and whalebone, ringed with Polynesian stick-chart wave swell notches and concentric sun rings.
  * **The Sweeping Hand:** A polished obsidian needle that casts a sun/moon shadow rotating smoothly across the face like a sundial gnomon.
  * **The Red Blip Contact:** When the shadow sweeps over a hostile raider war-canoe or predatory sea beast within detection range, an etched red ochre dot pulses brightly on the bone dial accompanied by the resonant strike of a hollow wooden slit-drum (*"Thump... thump..."*).
* **The "Far-Sight Reed Tube":**
  * An early optical tube assembled from hollowed bamboo, bound with sinew, and fitted with polished quartz and crystal lenses.
  * Looking through it shifts to a circular vignetted first-person scope with heat-shimmer refraction, allowing the hunter to spot distant smoke plumes and enemy sails beyond the naked eye's horizon.

### 5.2 Campaign B: The "Mariner's Astrolabe Sonar & Brass Spyglass"
* **The "Astrolabe Radar Dial":**
  * **Aesthetic:** A heavy, ornate 15th-century maritime brass astrolabe positioned on the ship’s binnacle / steering wheel console.
  * **The Sweeping Hand:** The *Alidade* (brass sighting rule) slowly rotates 360 degrees, driven by clockwork gears or celestial alignment.
  * **The Red Blip Contact:** Whenever the sweeping alidade faces an incoming pirate ship or hostile reef hidden in coastal fog, an internal chime sounds (like a submarine ping: *"Dinggg..."*), and a glowing crimson ember blip appears on the etched latitude ring, showing exact bearing and distance!
* **The "Brass Collapsible Spyglass":**
  * Authentic 3-draw brass maritime telescope.
  * When drawn (`Right Mouse Click` or `Left Trigger`), the screen transitions smoothly into the circular brass aperture with crosshairs, distance notches, and wind-drift indicators.
  * Highlights target vessels with informational overlays: ship type (e.g., *Pirate Sloop*), crew armament, and carried loot estimation.

---

## 6. Narrative Architecture: Storylines & Dynamic Quests

### 6.1 Campaign A: "The Great Crossing" (Prehistoric Saga)
* **Main Narrative Arc:**
  You are the designated Navigator-Hunter of the Paleolithic Sunda clan. A severe ice-age drought and vanishing megafauna threaten your people. An ancient Shaman prophecy speaks of the *"Great Southern Land Across the Salt Water"* (Sahul/Australia). You must guide your clan across deadly island straits, invent the outrigger canoe, overcome ocean storms, fight off ruthless sea-raider tribes, and kindle the first sacred fire on the untouched shores of Sahul.
* **Key Questline:**
  1. *The Dying Hearth:* Gather dry timber and flint to maintain the tribe's eternal fire during torrential monsoons.
  2. *The Hunter's Trial:* Stalk and bring down a giant *Diprotodon* to feed the tribe and harvest sinew for canoe lashings.
  3. *The Tree of the Voyagers:* Locate the giant Ironwood tree in deep jungle to hollow out the first ocean-going hull.
  4. *The Raided Convoy:* Defend the maiden voyage from mangrove raiders; if ransacked, hunt them to their coral fortress.
  5. *Reading the Stars:* Align the bone astrolabe with the Southern Cross to navigate the open ocean without landmarks.
* **Side Quests:**
  * *The Cave of Hands:* Discover a sacred limestone cavern and mix pigments to paint your clan's handprints, unlocking tribal wisdom buffs.
  * *The Megafauna Graveyard:* Brave the territory of the marsupial lion (*Thylacoleo*) to harvest mammoth ivory for legendary spears.
  * *Lost Children of the Reef:* Rescue shipwrecked clan fishers stranded on a barrier reef before tiger sharks arrive.

### 6.2 Campaign B: "Terra Incognita" (Age of Discovery Saga)
* **Main Narrative Arc:**
  You are an ambitious captain granted an expedition charter by the Crown. While old scholars insist the western ocean drops off into an abyss of sea dragons, you follow Harari's *"Discovery of Ignorance"* thesis: the greatest glory belongs to whoever dares to explore a blank map. You must navigate across the Atlantic, survive crew scurvy and brewing mutinies, fight off rogue pirate fleets lying in wait in the Caribbean, discover valuable New World trade goods, and construct the first lasting colony.
* **Key Questline:**
  1. *The Royal Contract:* Secure funding, crew, and rations in Seville/Lisbon before setting sail into the unknown.
  2. *The Void of Water:* Maintain crew morale and ration hardtack while sailing weeks without sighting land.
  3. *The Skull Banner of the Sargasso:* Evade or destroy the dreaded pirate flagship *The Crimson Leviathan* patrolling the spice choke points.
  4. *Landfall & Colony Foundation:* Drop anchor in a turquoise bay, claim the shore, and build a wooden palisade outpost (*Fort San Salvador*).
  5. *The King's Cargo:* Fill the caravel's hold with gold, mahogany, and spices, survive the hurricane return voyage, and earn royal nobility.
* **Side Quests:**
  * *The Botanist's Remedy:* Seek exotic wild citrus and medicinal bark in dense tropical jungles to cure a lethal scurvy outbreak.
  * *The Sunken Spanish Galleon:* Dive into shark-patrolled coral reefs to recover sunken bullion chests and rare naval culverin cannons.
  * *Mutiny on the Horizon:* Discover coded notes in the ship's bilge; placate the crew with rum or arrest the conspirators before they throw you overboard.

---

## 7. Controls & Input Mapping Reference

### 7.1 Keyboard & Mouse (PC — macOS & Windows)
* **`W` / `A` / `S` / `D`:** 3D Movement (Forward / Left / Backward / Right)
* **`Shift` (Hold):** Sprint (Consumes Stamina; replenishes when resting)
* **`Space`:** Jump (Consumes Stamina)
* **`Left Mouse Button`:** Attack / Spear Thrust / Fire Swivel Cannon
* **`Right Mouse Button` (Hold):** Aim / Look through Far-Sight Scope or Brass Spyglass
* **`Mouse Motion`:** 3D Camera Orbit (when mouse is captured)
* **`Escape`:** Toggle Mouse Capture (Free cursor to interact with HUD or re-capture)
* **`E`:** Interact / Gather Harvestables / Board Ship / Steer Rudder
* **`Tab` / `I`:** Open Inventory & Cargo Manifest
* **`M`:** Open Chart / Empty Parchment Map

### 7.2 Gamepad (Xbox, PlayStation DualSense, Switch Pro on Mac)
* **`Left Stick`:** 3D Movement
* **`Right Stick`:** 3D Camera Orbit
* **`A` (Xbox) / `Cross` (PS):** Jump
* **`L3` (Click Left Stick):** Sprint Toggle
* **`Right Bumper (RB)` / `R1`:** Quick Attack / Spear Thrust
* **`Left Trigger (LT)` / `L2`:** Far-Sight Scope / Spyglass Zoom
* **`Right Trigger (RT)` / `R2`:** Heavy Thrust / Fire Ship Cannons
* **`X` (Xbox) / `Square` (PS):** Interact / Harvest / Open Chests
* **`Y` (Xbox) / `Triangle` (PS):** Toggle Bone-Dial / Astrolabe Radar HUD
* **`Menu` / `Options`:** Pause Menu & Settings

---

## 8. 3D Blender Asset Pipeline & File Layout

```
sapiens_survival/
├── assets/
│   ├── materials/               # PBR terrain, water, bark, stone shaders
│   └── models/
│       ├── spear.glb            # Flint survival spear (Campaign A)
│       ├── campfire.glb         # Stone hearth & embers (Campaign A)
│       ├── rock.glb             # Low-poly mineral node
│       ├── tree.glb             # Prehistoric & tropical flora
│       ├── caravel.glb          # 15th-century sailing ship (Campaign B)
│       ├── pirate_sloop.glb     # NPC Pirate raider ship
│       ├── war_canoe.glb        # Coastal raider war-canoe (Campaign A)
│       ├── cargo_chest.glb      # Storable cargo crates & loot bags
│       ├── bone_radar.glb       # Handheld ancient carved bone dial
│       ├── spyglass.glb         # 3D brass telescope prop
│       └── palisade_wall.glb    # Modular colony defensive fortifications
├── scenes/
│   ├── main.tscn                # Main 3D test arena & world
│   ├── player.tscn              # 3D third-person character & camera rig
│   ├── ui/
│   │   ├── ancient_hud.tscn     # Premium stylized bone/parchment survival HUD
│   │   ├── sonar_radar.tscn     # Rotating sweeping sonar radar component
│   │   └── spyglass_view.tscn   # Optical zoom vignette & reticle overlay
│   └── age_of_sail/
│       ├── ocean_world.tscn     # Dynamic 3D ocean, wind & wave system
│       ├── caravel_ship.tscn    # Steerable 3D ship physics controller
│       └── pirate_ship.tscn     # NPC pirate ship AI & combat
├── scripts/
│   ├── player_controller.gd     # 3D movement, combat, stamina, input mapping
│   ├── hud.gd                   # Dynamic vitals & ancient UI animations
│   ├── radar_controller.gd      # Sonar sweeping needle & enemy blip pinging
│   ├── pirate_ai.gd             # NPC ambush, cargo targeting & fleeing logic
│   └── world.gd                 # Sun orbit & day/night lighting cycle
└── tools/
    ├── generate_assets.py       # Blender automation: survival props & environment
    ├── generate_ship.py         # Blender automation: 3D Caravel & pirate sloop
    ├── generate_canoe.py        # Blender automation: War-canoes & outriggers
    └── generate_radar_props.py  # Blender automation: Bone dial & brass spyglass
```

---

## 9. Multi-Milestone Roadmap

* [x] **Milestone 1: Prehistoric Foundation & Core Controller (COMPLETED & RUNNING)**
  * 3D Third-person character controller, stamina/hunger HUD, test arena.
  * Headless Blender generator for flint spear, campfire, rocks, and trees.
  * Real-time Metal rendering on macOS.
* [ ] **Milestone 2: AAA Visual & UI Overhaul (NEXT PRIORITY)**
  * Replace placeholder progress bars with an authentic, organic survival HUD (curved bone/parchment meters, animated stamina pulse, high-res iconography).
  * Build the era-appropriate "Sonar Radar" widget (concentric rings, rotating needle hand, pinging red enemy blips).
  * Build the "Far-Sight Scope" / Spyglass zoom overlay.
* [ ] **Milestone 3: NPC Pirates, Cargo System & Retribution Cove**
  * Cargo items (crates, pelts, obsidian) with weight and "Piracy Heat".
  * NPC raiders (war-canoes in Campaign A, pirate sloops in Campaign B).
  * Retribution quest system: Raid the pirate lair to win back stolen loot.
* [ ] **Milestone 4: Online Multiplayer "Land Rush" Rivalry**
  * Godot high-level multiplayer networking (ENet / WebSockets).
  * Land claiming mechanics, territory scoreboards, and rival outpost raiding.
* [ ] **Milestone 5: 3D Age of Sail Ocean, Caravel & Naval Combat**
  * Blender-generated Caravel and pirate flagship.
  * Wave buoyancy physics, wind direction trimming, and deck cannon firing.
* [ ] **Milestone 6: Console Porting & Gamepad Optimization**
  * Windows/DirectX build, Xbox Series & PS5 controller haptics and console packaging.
