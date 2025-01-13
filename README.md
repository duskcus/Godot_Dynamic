# Godot Dynamic
**WIP:** A Godot kit that makes creating interactive UI faster. It uses Godots build in plugin system to create custom nodes you'd often use in your game. Because its dynamic you can prototype faster giving you more time to design the game.

## Roadmap

**Curently has**
- Dynamic nav menu
- Dynamic menu items

**In progress**
- Dynamic menu themes
- Dynamic input mapper
- Saving and loading with JSON

**Future idea's starter kit**
- Dynamic HUD
- In game menu
- Achievement system
- Inventory system
- Dialogue manager
- Enemy AI
- Dynamic audio switcher

## How to use
1. First add this plugin into your addons folder, you might need to restart Godot.
2. In the folder you can find the names of each custom node, if your not going to use them you may delete them to reduce bloat. Probably when your project is finished.

**Dynamic nav menu**
1. In a scene add a new node and pick DynamicMenu.
2. In the right panel fill in the text array with the desired menu items.
3. For the menu items make a textarray or a standard array depending whether you.
4. Start your project and the navbar should be instanced with those corresponding items.

Example:  
Navbar enabled = [x]  
Navbar Array [Home, Settings]  
Menu Items Array [[Child of Home, Child2 of Home], Child of Settings]  
