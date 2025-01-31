# Godot Dynamic
Godot Dynamic provides easily customisable components for common tasks like menus, saving you the trouble of setting them up in every unfinished side project.

## Roadmap

**Current functionality**
Plugin is still in alpha

**In progress:**
- Dynamic main menu
- Dynamic menu themes
- Dynamic input mapper
- Saving and loading with JSON

**Future components:**
- Dynamic HUD
- In game dynamic menu
- Achievement system
- Inventory system
- Dialogue manager

**Possible future components:**
- Dynamic audio switcher
- Peer to peer networking
- Enemy AI

## How to use
1. First add this plugin into your addons folder, you might need to restart Godot.
2. In the folder you can find the names of each custom node, if your not going to use them you may delete them to reduce bloat. Probably when your project is finished.

**Dynamic menu**
1. In a scene add a new node and pick DynamicMenu.
2. In the right panel fill in the text array with the desired menu items.
3. For the menu items make a textarray or a standard array depending whether you.
4. Start your project and the navbar should be instanced with those corresponding items.

Example:  
Navbar enabled = [x]  
Navbar Array [Home, Settings]  
Menu Items Array [[Child of Home, Child2 of Home], Child of Settings]  
