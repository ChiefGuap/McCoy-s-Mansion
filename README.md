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

## Om Patki (oypatki@ucdavis.edu)
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
- **Dynamic Dialogue Formatting:** Implemented dynamic adjustments to the dialogue box size, font size, and color to distinguish between simple flavor text and critical discovery moments.[Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L86-90), 
[Chair](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/chair.gd#L72-76), 
[Clock](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/clock.gd#L113-116), 
[Vase](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/vase.gd#L79-82)
- **Clue and Item Popups:** Created the logic to toggle the visibility of special UI popups ($Original or note) when an item or clue is discovered, such as the note from the clock or the hidden paper clue, and included logic to ensure the popup automatically closes if the player leaves the interaction area (_on_*_exited function).[Bed](https://github.com/ChiefGuap/McCoy-s-Mansion/tree/main/scripts/bedroom/bed.gd#L108-118), 
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

# Main Roles


# Sub-Roles


# Other Contributions 
