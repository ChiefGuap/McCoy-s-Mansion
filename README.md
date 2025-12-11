# McCoy's Mansion #

## Summary ##

This is an escape-room horror game where the player must navigate through a series of rooms, finding clues, solving puzzles, and piecing together the path to freedom. But every step comes with danger. Certain suspicious items are scattered throughout the environment, and interacting with the wrong one will trigger a jumpscare that drastically reduces the timer. The tension never lets up, because the whole time the player has to keep an eye on that countdown. If the timer hits zero, the player loses. But if they can avoid the traps, uncover the clues, and escape all the rooms before time runs out, they win the game. It’s a fast-paced, suspenseful mix of puzzle-solving and survival, designed to keep players on edge from start to finish.

## Project Resources

[Play the Game](https://ripetomato3.itch.io/mccoys-mansion)

[Trailer](https://www.youtube.com/watch?v=IYF02bDhPTo)

[Press Kit](https://dopresskit.com/)  

[Initial Plan/Proposal](https://docs.google.com/document/d/1sA2XxWCMnUcR5FnoEW7Uw0EvomDNiPJk1OjwOKdOJOg/edit?usp=sharing)  

## Gameplay Explanation ##

The player can move around the rooms using either WASD or the arrow keys, letting them explore every corner as they search for clues. Interacting with items is simple. Just press E on the keyboard. Certain objects can be picked up, and anything the player collects will appear in their hotbar. If the player picks up more than one item, they can press the number key that corresponds to that item’s position in the hotbar to focus on it. From there, they can choose to use the item whenever they’re ready. This system lets players quickly switch between tools and clues as they work their way through the puzzles and dangers of each room. The optimal strategy to win the game is to read between the lines of each clue and then survey the environment for objects that relate to the clue and interact with those objects.


# External Code, Ideas, and Structure #

Although we did take inspriration from some other games, we didn't use any external code or structure to build the game. Everything you see is authored by us. 

# Team Member Contributions

This section be repeated once for each team member. Each team member should provide their name and GitHub user information.

The general structures is 
```
Team Member 1
  Main Role
    Documentation for main role.
  Sub-Role
    Documentation for Sub-Role
  Other contribtions
    Documentation for contributions to the project outside of the main and sub roles.

Team Member 2
  Main Role
    Documentation for main role.
  Sub-Role
    Documentation for Sub-Role
  Other contribtions
    Documentation for contributions to the project outside of the main and sub roles.
...
```

For each team member, you shoudl work of your role and sub-role in terms of the content of the course. Please look at the role sections below for specific instructions for each role.

Below is a template for you to highlight items of your work. These provide the evidence needed for your work to be evaluated. Try to have at least four such descriptions. They will be assessed on the quality of the underlying system and how they are linked to course content. 

*Short Description* - Long description of your work item that includes how it is relevant to topics discussed in class. [link to evidence in your repository](https://github.com/dr-jam/ECS189L/edit/project-description/ProjectDocumentTemplate.md)

Here is an example:  
*Procedural Terrain* - The game's background consists of procedurally generated terrain produced with Perlin noise. The game can modify this terrain at run-time via a call to its script methods. The intent is to allow the player to modify the terrain. This system is based on the component design pattern and the procedural content generation portions of the course. [The PCG terrain generation](https://github.com/dr-jam/CameraControlExercise/blob/513b927e87fc686fe627bf7d4ff6ff841cf34e9f/Obscura/Assets/Scripts/TerrainGenerator.cs#L6).

You should replay any **bold text** with your relevant information. Liberally use the template when necessary and appropriate.

Add addition contributions int he Other Contributions section.

## Om Patki (oypatki@ucdavis.edu): opatki

### Main Role - User Interface and Input
Although my main role was user interface and input, my team was also required to work with user interaction since we divided up the work and implemented different levels of the game. Since this was my main role, we decided that I'd be in charge of the user interface and input for the largest portion of the game (Level 3). Here are my contributions relevant to this aspect of the game:

- **Interaction Input System:** Implemented the primary interaction mechanism (Input.is_action_just_pressed("interact")) to manage all object interactions, including displaying dialogue, checking puzzle conditions, and toggling UI elements. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L38), 
[Couch](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bottom_red_couch.gd#L35), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L49), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L40), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L46)
- **Dialogue Box Management:** Developed the logic for displaying and hiding a common dialogue box (DialougeBox) and text label (DialougeText) to provide immediate feedback to the player upon interaction. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L44-46), 
[Couch](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bottom_red_couch.gd#L38-40), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L54-56), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L44-45), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L77-78)
- **Dynamic Dialogue Formatting:** Implemented dynamic adjustments to the dialogue box size, font size, and color to distinguish between simple flavor text and critical discovery moments. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L86-90), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L72-76), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L113-116), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L79-82)
- **Clue and Item Popups:** Created the logic to toggle the visibility of special UI popups ($Original or note) when an item or clue is discovered, such as the note from the clock or the hidden paper clue, and included logic to ensure the popup automatically closes if the player leaves the interaction area (_on_*_exited function). [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L108-118), 
[Paper](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/paper.gd#L39), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L66-82), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L101-111)
- **Time Input UI:** Created and integrated a dedicated CanvasLayer UI with a LineEdit for the clock puzzle, connecting the text_submitted signal to a function (_on_time_input_submitted) to validate the user's HHMM time input. This system handles input validation and error messaging (e.g., "Invalid format. Use HHMM") before setting the time. [Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L17-19),
- **Inventory (Hotbar) Integration:** Managed the visibility of the player's hotbar UI, hiding it during dialogues, jumpscares, or when a puzzle-specific UI (like the clock input or a discovered note) is open to enforce player focus. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L57), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L64), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L52), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L75)
- **Collectible Item Logic:** Implemented the core mechanics for the Bottle and Torch items, allowing them to be added to and removed from the Hotbar, and controlling their visibility and global position after collection. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L57), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L64), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L52), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L75)


### Sub-Role - Game Feel
Here is the game feel items I added to level 3 to improve user experience and make the player more immersed in the game.

- **Jumpscare Implementation:** A dedicated, randomized jumpscare mechanic was implemented across five interactable objects (bed.gd, bottom_red_couch.gd, chair.gd, clock.gd, vase.gd), giving the player a 40% chance (randf() < .60 in the negative case) of triggering a scare. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L42), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L52), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L42), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L48)
- **Audio-Visual Shock:** This mechanic involved:
    - Locking player movement (player.lock_player()) and hiding the hotbar. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L57-58)
    - Instantly playing a scare sound (scream_sound.play()). [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L60)
    - Flashing the dedicated jumpscare image/layer (jumpscare_layer.visible) multiple times using timed delays (await get_tree().create_timer(0.05).timeout) for a brief, jarring visual effect. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L62-65)
    - Unlocking the player once the scare sequence finishes. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L72)
- **Pacing and Cinematic Control:** Used the await get_tree().create_timer(duration).timeout mechanism extensively to pause game flow, ensuring the player is locked in place while reading dialogue or viewing an item discovery event. [Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L47), [Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L51)


### Other Contributions
I had a major role in coming up with the puzzles and implementing them. Here are some of my other contributions that don't relate to my 2 assigned roles.

- **Paper Clue Combination Puzzle:** Created a multi-step interaction puzzle for the Paper object :
    - **Using the Bottle item** (presumably cleaning fluid) on the paper reveals the underlying clue by setting a dirty overlay to invisible. [Logic](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/paper.gd#L32-34)
    - **Using the Torch item** (presumably UV/blacklight) after cleaning the paper reveals a final blue ink message by making a blue overlay invisible, which marks the puzzle as complete (Level3.paper_done = true). [Logic](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/paper.gd#L35-38)
- **Hidden Item Discovery:** Implemented a spatial puzzle where a hidden item under the bed is only discovered if the player interacts while standing within a very specific coordinate range (player.position.y > 90 and player.position.y < 120 and player.position.x > -240 and player.position.x < -220). [Discovery of hidden note](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L80-81)
- **Vase Break Mechanic:** Implemented a one-time destruction mechanic for the Vase (vase_broken = true), which unlocks the clue hidden inside and updates the game state (Level3.vase_done = true). [Breaking the vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L84-85)
- **Clock Puzzle Win Condition:** Wrote the logic to check for the successful completion of the clock puzzle, which requires the player to input the exact time "0607" via the UI to set current_time to "06:07" and trigger the appearance of a final note (note_unlocked = true). [Winning the clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L156-163)
- **Game-Winning Mechanic (Chair):** Created the final, game-ending interaction with the Chair, where the character pushes it into a new position (self.position += PUSHED_IN_POSITION) and immediately triggers the WinScreen.tscn. [Final push](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L82-84)
- **Level State Management:** Implemented state flags in global Level3 (e.g., Level3.bed_done, Level3.clock_done, Level3.vase_done, Level3.paper_done, Level3.chair_done) to gate interactions, ensuring puzzles are completed in sequence or preventing repeat discovery events. [Flag for progression](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/main/scripts/level_3.gd#L3-7)


## Raquib Alam (rmalam@ucdavis.edu): 

### Main Role - Gameplay Programmer and Systems Architect
##### original role: Data & Analytics Engineer
Reflective Statement: At the beginning of the quarter, my intended role was to be a Data and Analytics Engineer. My goal was basically to focus on the backend telemetry and user pathing analysis. However, as the development progressed, I found a critical role and need to fill for our grpup/project to bridge the gap between the assets and the game loop. I then realized that I needed to pivot and I pivoted my role to be a Gameplay Programmer, focusing on the texhnical and visual implementation of narrative events, stage management, and also interactions of the user systems (hotbar, main menu screen, how to play screen, end screen for examples). While I maintained a strong focus on "improving the user experience" (this was my intended original goal), I achieved this through direct systems engineering rather than the passive data analysis.

- **Cinematic Sequencer and the State Management:** I engineered the game's narrative flow and control system. This involved creating a custom CutsceneManager that synchronizes AnimationPlayer tracks with GDScript logic (Tweens, Signals). I also implemented a "Player Lock" state pattern (modifying _input and _physics_process) to ensure narrative events—such as the opening sequence in the woods—could play out without user interference, fulfilling the course requirement for Finite State Machines (FSM). [Link to scripts/intro_woods.gd]()

- **Probabilistic Event System RNG:** To meet the "replaybility" code/goal of the game, I made sure to design a randomized jumpscare system for the third level of the game. I wrote a modular script to basically extend the base interaction class the uses the randf() to calculate a 40% probability of triggering a "haunt" event vs a standard interaction. EVen though the jumpscare idea was a whole group idea, I took the charge and implemented the jumpscares on every level. I made sure to work with my team members who were specifvslly working on that level to implement the jumpscares on certain objects that they wanted and also learned and implemented toggle ability on those objects as well. This required me to manage the audio streams, the visual overlays (The CanvasLayers) and also communicating with the global game state to apply the time penalties. Every object that was intractable with the game has the jumpscare function instilled within the code with the randf and this demonstrates practical application of Random Number Generation in game design. [example to one of the scripts of scripts/bedroom/bed.gd]()
  
- **Game Loop and Signal Architecture:** I took the main ownership of the global game loop controller (Game.gd). I implemented the 7-minute countdown timer that basically enforces the win/lose condition. The only time that the data engineer side of the job came through here where I logged players (students) playing the game and then I figured out the perfect time for the game would be. By testing this game over 34 students, I was able to see patterns on how they moved throughout the game and timestamped them every time thyey finished the level and on average they finished the game at 6:23 seconds so I decided to put 7 minutes. Furthermore, I decoupled the timer initialization from the scene load by creating a custom signal (cutscene_finished) ensuring the gameplay timer only will begin after the narrative intro concludes. The seperation of concerns is a principle, a key principle, of Game Architecture [Link to scripts/game.gd]

- **Dynamic UI and Inventory Feedback:** Building upon the inventory system developed by my teammate Sreya, I enhanced the user feedback loop by developing a procedural script for the hotbar. This system instantiates and positions a "Selector Box" node in real-time based on the player's active item slot. This replaced static assets with dynamic code, allowing for a flexible UI that adapts to the grid layout automatically and ensures items remain centered. [Link to scripts/hotbar.gd]

### Sub-Role - Gameplay Testing
Confidence: 5/5 Explanation. This sub-role remianed consistent with the original projectv plan proposal. As the person who was integrating the cutscenes, making the cutscenes and doing the same for the jumpscares, I was the primary tester for the "game Feel". I took a lot of time to really hone/lock in to test the collision logic for the "vase puzzle" in level 2 and the timing windows for the jumpscares to make sure that they felt fair but also a bit startling at the same time. I identifies and also fixed the critical bugs regarding the player state (The player getting stuck ion a locked state when the cutscene was skipped) and I also ensured that the UI was scaled correctly across the different resolutions, especially when the game was pushed.

- **Audio Visual Shock System for Jumpscares:** I engineered a reusable "Shock" sequence to create immediate tension: Input Locking: Overriding the player's input loop (player.is_locked = true) and hiding the hotbar to force focus on the event. Audio Feedback: Triggering instantaneous, high-priority audio streams (scream_sound.play()) synchronized with visual effects. Visual Strobing: Implementing a coroutine-based strobe effect that toggles the jumpscare layer visibility multiple times with micro-delays (await get_tree().create_timer(0.05).timeout) to create a jarring, disorienting visual. State Restoration: Automatically unlocking the player and restoring UI elements once the sequence concludes.
- **Game Pacing and Control of the Cinematics:** I utilized await timers extensively to control the narrative flow. This mechanism pauses script execution while keeping the game loop running, allowing for timed dialogue delivery and suspenseful pauses before item reveals or scares. This ensures the player cannot skip critical narrative beats.
[Evidence in Intro Woods]() [Evidence in Bed Interaction]()

### Other Contributions
- **Shader Implementation:** Integrated a custom GLSL shader (dizzy_blur.gdshader) for the intro sequence to simulate the protagonist waking up. [Link to shaders/dizzy_blur.gdshader]
- **Camera Logic: Configured:** Camera2D limits and zoom levels across multiple scenes to ensure immersion.
- **Menu Flow:** Designed and scripted the logic for the Main Menu and "How to Play" screens, including scene transitions.

## Aarav Jain (apjain@ucdavis.edu)

### Main Role – Game Systems & Win/Lose Flow


- **Global Horror Timer System** – Implemented the core countdown timer that drives the game’s pressure and pacing. The timer is initialized to 6 minutes and persists as a global system that updates once per second, formats time as mm:ss, and lives in game.gd. I used Godot’s scene tree and signal system (_on_timer_timeout) to integrate the timer into the main game loop, and applied course ideas around game state and win/lose conditions. The timer controls when the player loses (time reaching zero) and also feeds directly into the game feel systems (color changes and pulse). [Link to scripts/game.gd]
(Evidence: scripts/game.gd in the root scene game.tscn.)

- **Dynamic Timer Feedback & Visual Game Feel** – Extended the basic timer into a readable and expressive UI element that reflects urgency. When the remaining time falls below 3 minutes, the timer label turns yellow; below 1 minute, it turns red and begins a subtle “haunted” pulse effect by scaling with a sine wave over time. This uses concepts from class about feedback loops and player-facing state representation—turning raw state into visual tension cues. [Link to scripts/game.gd]
(Evidence: color and scaling logic in update_timer_label() and _process() in scripts/game.gd.)

- **Jumpscare Time Penalty Integration** – Designed and implemented a reusable function apply_jumpscare_penalty() in game.gd that subtracts 30 seconds from the global timer whenever any jumpscare triggers. This function is called by multiple jumpscare scripts across different levels, decoupling the scare logic from the time system while still tying them together through a shared interface. This follows the separation of concerns and modular design emphasized in the course.[Link to scripts/game.gd]
(Evidence: apply_jumpscare_penalty() in scripts/game.gd, called from jumpscare interaction scripts such as the bedroom/level jumpscare controllers.)

- **Game Over Flow (Lose Screen)** – Implemented the full “time’s up” game over pipeline. When the timer reaches zero, the game transitions to a dedicated GameOver scene that displays a stylized game over UI with two options: Retry and Quit. I wired the buttons via signals so Retry reloads Level 1, while Quit returns the player to the main menu. This work ties into scene management and UI control from the course—using change_scene_to_file() and Control-node based menus to implement a clean lose condition. [Link to game_over.gd]
(Evidence: game_over.tscn and game_over.gd handling Retry → res://game.tscn and Quit → res://main_menu.tscn.)

- **Win Screen & Ending Flow** – Created and integrated the winning screen that appears when the player successfully escapes the mansion. The win screen presents an AI-generated image of McCoy and gives the player options to either Replay (send them back to Level 1) or Quit (back to main menu). This mirrors the game over flow but for the win condition, and demonstrates how the same scene-transition tools can be used to close the loop on a full game experience.[Link to WinScreen.gd]
(Evidence: WinScreen.tscn and associated script that routes Replay to game.tscn and Quit to main_menu.tscn.)

### Sub-Role – Audio & Game Feel Support

- **Global Background Music System** – Implemented a reusable background music manager (MusicManager.gd) that plays a looping horror ambience track across the game. The system uses an AudioStreamPlayer attached to a manager node (or autoload) to avoid restarting music on every scene change, reflecting ideas from the course about persistent systems and singletons. I also configured the looping, volume, and placement of the MP3 (res://assets/world_scene/horror-background-atmosphere-for-suspense-166944.mp3) so the audio continuously supports the horror atmosphere.
[Link to MusicManager.gd] 
(Evidence: MusicManager.gd and scene where the audio player is created and added to the tree.)

- **Jumpscare Collaboration & Integration** – Worked closely with Raquib on the jumpscare system to ensure each scare not only showed visuals and played sounds but also correctly affected global game state. I helped hook up the jumpscare scripts to call the shared apply_jumpscare_penalty() function and made sure the timer UI updated immediately after each scare. This ties into the course’s focus on coordinating multiple systems (UI, audio, and core gameplay state) through a central controller.
(Evidence: jumpscare interaction scripts (e.g., bed/room scare scripts) calling into game.gd’s penalty function; coordination with player lock/hotbar visibility.)

### Other Contributions

- **Menu & Flow Polish** – Assisted with testing and debugging transitions between main menu, Level 1, Level 2, Level 3, the win screen, and the game over screen, ensuring that the timer, music, and UI reset or persist correctly depending on the context. This involved iterating on scene paths, button callbacks, and checking that the player always returns to the intended starting state when replaying.
(Evidence: Scene transition logic between main_menu.tscn, game.tscn, GameOver.tscn, and WinScreen.tscn.)

- **General Integration & Bug Fixing** – Helped teammates debug issues around timer behavior, scene loading, and jumpscare interactions (such as making sure scares did not soft-lock the player and that time penalties couldn’t take the timer negative). This collaborative work contributed to making the final build feel cohesive and stable rather than a collection of disconnected scenes.


## Sreya Mathew (ssmathew@ucdavis.edu): tiramisuuuuuuu

### Main Role - Game Logic
Reflective statement: My original role in the team was Procedural Content Generation, but as we fleshed out our game idea, we felt that intentful, human-made levels/puzzles fit the narrative of our game better and we found a different way to factor replayability and difficulty into our game. Instead, since we had instead found that a lot of our work lay in Game Logic, having many core game features, such as timers, stateful interactions, etc. to implement, I switched my role to Game Logic, which I share with my teammate Aarav. In this role, I worked on the following:

- **Multiple-selection interaction system:** Developed a system to be able to detect the collision areas of multiple nearby objects and toggle between them, so the player can select which to interact with. To implement this, I had the Player node keep an Array of Interactable objects (updated for each on_area_2d_entered and on_area_2d_exited it received) and had it handle “e” and “x” presses, by invoking the correct member functions of the Interactable objects. [logic in player.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/player.gd#L46-L63)

- **Abstract class for Interactables:** I made an abstract class, inspired by our CommandExercise, called Interactable which guaranteed that objects we wanted to integrate into our multiple-selection interaction system had the correct named functions (such as an interact function that the Player can invoke). The Interactable class also included default implementation for turn_on_interactable (which added the light highlight), turn_off_interactable (which completely removed highlights), turn_on_outline (which added hard highlight), and turn_off_highlight (toggle back to light highlight), to reduce code duplication. [interactables.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/dining_room/interactable.gd#L1-L22)

- **Inventory system:** I implemented the inventory system, which initialized 5 inventory slots, copied the Sprite texture of any node added to the Inventory into a slot, and kept an Array of references to nodes added to the inventory. I made it so the user can press any of the number keys (1-5) that correspond to the slots to be able to “hold” an item. I created functions for add_to_hotbar, remove_from_hotbar, and get_held_item [hotbar.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/hotbar.gd#L96-L112)

- **Level 2 Manager:** I created the script called level2.gd to monitor if the puzzle is complete. Whenever a user placed vases on tables, the table would emit a signal that contained the Table-Vase pair and when a Vase was picked up off the table, it would emit a signal to remove the Table-Vase mapping. On each update, the level2.gd checked if the table_vase_dictionary matched the correct mapping of vases to tables. [level2.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/level_2.gd#L42-L48)

- **Stateful interactions for Level 2/Dining Room:** I developed the interactions on objects in level 2. Some stateful interactions include that the drawer can only be interacted with while holding a key, the chair removes interactability after retrieving the key, and the tables change text whether there is a vase on it. [table_1.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/dining_room/tables/table_1.gd#L14-L32)

### Sub-Role - Game Feel
I worked on honing in the game feel of Level 2. I worked with feedback from my teammates to make the level more fun to play and solve bugs.

- **Improved replayability of Level 2:** Our original gameplay flow for level 2 was the player needs to interact with Mccoy’s Chair in the dining room to get a key to a drawer, and unlocking the drawer would trigger vases to appear on the table (initiating the main puzzle of placing the vases). I received feedback from my teammate Andy that forcing the players to do the level 2 puzzle in sequential order would become frustrating for those who had to restart multiple times (if they weren’t able to complete the puzzles in time and reached the game over, many times). So I worked with Andy to hash out a new design for level 2, where the vases are already out of place on the dining table when the player enters the room, and the Player can either speedrun and place the vases how they already know or they can follow through the chair-to-drawer pipeline to receive the note with hints on how to place the vases (if it’s their first run through of the level).

- **Randomization of interactions:** I created a set of dialogs that randomly get selected when interacting with chairs in the dining room, to add a sense of humour and which reinstate the initial hint of “Where is Mccoy’s Chair”. [chair.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/dining_room/chair_front_facing.gd#L9-L16)

- **Tooltips for interactions:** 2 tooltips that hint “e to interact” or “x to toggle” + the number of toggleable items as a quick refresher of key commands. [logic in player.gd](https://github.com/ChiefGuap/McCoy-s-Mansion/blob/af84841042e5d86899534a069bf4a19a39944893/scripts/player.gd#L131-L138)

- **Collisions in Level 2:** I put attention to detail on the collisions and zIndex of the dining room tiles to create a room that made sense physically and increased the difficulty of the puzzle, due to the cluttering of chairs which narrowed the space of movement to the user.



# Main Roles


# Sub-Roles


# Other Contributions 
