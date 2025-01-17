@tool
extends Control
# 1. check for bools
# 2. if active create export var with get set (array for menus)
# 3. create if data inside export var else skip
# 4. build nav based on children in hbox
# 5. build menu based on children in vbox

#region: Variables
#Export Variables
var navbar_links: PackedStringArray:
	set(value):
		var old_links = navbar_links
		navbar_links = value
		if _instance:  # Only update if menu exists
			update_navbar_links(old_links, value)

var menu_links: Variant:
	set(value):
		var old_links = menu_links
		menu_links = value
		if _instance:  # Only update if menu exists
			update_menu_links(old_links, value)

# Boolean flags to control menu features
@export var navbar: bool = true:
	set(value):
		navbar = value
		notify_property_list_changed()  # This triggers property list refresh

@export var header: bool = true
@export var tooltip: bool = true

#Constants
# Preload the menu scene to avoid loading it multiple times
const DYNAMIC_MENU_SCENE = preload("res://addons/godot_dynamic/scenes/dynamic_menu/dynamic_menu.tscn")

#Member Variables
# Stores reference to the instantiated menu scene
var _instance: Node
#endregion

# 1. Changes inspector based on active bools
func _get_property_list() -> Array:
	var properties = []
	# Only show navbar_links if navbar is true
	if navbar:
		properties = []
		properties.append({
			"name": "navbar_links",
			"type": TYPE_PACKED_STRING_ARRAY,
			"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		})
		properties.append({
			"name": "menu_links",
			"type": TYPE_ARRAY,
			"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		})
	elif !navbar:
		properties = []
		properties.append({
			"name": "menu_links",
			"type": TYPE_PACKED_STRING_ARRAY,
			"usage": PROPERTY_USAGE_DEFAULT | PROPERTY_USAGE_SCRIPT_VARIABLE
		})
	
	#print(properties)
	return properties

# 2. Creates the initial menu structure with both navbar and menu items
func create_initial_menu() -> void:
	# Create items for navbar
	if navbar_links and navbar:
		create_navbar_items(navbar_links)
		create_menu_items(menu_links)
		$DynamicMenu/Panel.visible = true
	# Create items for menu
	if menu_links and !navbar:
		create_menu_items(menu_links)
		$DynamicMenu/Panel.visible = false

# Creates the top navigation bar items and their corresponding content containers
func create_navbar_items(links: PackedStringArray) -> void:
		
	for i in links.size():
		var item = links[i]
		# Create navbar button for navigation
		var button = Button.new()
		button.name = item  # Use item text as node name for easy reference
		button.text = item
		$DynamicMenu/Panel/HBoxContainer.add_child(button)
		
		# Create vertical container for menu items associated with this navbar item
		var vbox = VBoxContainer.new()
		vbox.name = str(i)  # Use index as name for consistent referencing
		vbox.layout_mode = 1
		vbox.set_anchors_preset(Control.PRESET_HCENTER_WIDE)
		$DynamicMenu.add_child(vbox)
		
		# Only show first tab's content by default
		vbox.visible = (i == 0)

# Creates menu items within their respective containers
func create_menu_items(links: Variant) -> void:
	if !navbar:
		var vbox = VBoxContainer.new()
		vbox.name = "menu"
		vbox.layout_mode = 1
		vbox.set_anchors_preset(Control.PRESET_HCENTER_WIDE)
		$DynamicMenu.add_child(vbox)
		
	for i in links.size():
		var item = links[i]
		var path
		# Construct path to the container for this menu item
		if menu_links and navbar:
			path = "DynamicMenu/" + str(i)
		elif menu_links and !navbar:
			path = "DynamicMenu/menu/"
		var vbox = get_node_or_null(path)
		
		# Skip if container doesn't exist
		if not vbox:
			continue
		
		# Handle both array of items and single items
		if item is PackedStringArray:
			# Create multiple buttons for array items
			for menu_item in item:
				add_menu_button(vbox, menu_item)
		else:
			# Create single button for non-array items
			add_menu_button(vbox, str(item))

# Helper function to create and configure menu buttons
func add_menu_button(parent: Node, text: String) -> Button:
	var button = Button.new()
	button.name = text  # Use text as node name for easy reference
	button.text = text
	parent.add_child(button)
	return button

# Updates navbar when links change, minimizing recreations
func update_navbar_links(old_links: PackedStringArray, new_links: PackedStringArray) -> void:
	var navbar_container = $DynamicMenu/Panel/HBoxContainer
	
	# Remove all existing buttons and store their data
	var existing_buttons = {}
	for child in navbar_container.get_children():
		existing_buttons[child.name] = child
		child.queue_free()
	
	# Process items in order
	for i in new_links.size():
		var item = new_links[i]
		var unique_name = _get_unique_button_name(item, i)
		
		# Create new button
		var button = Button.new()
		button.name = unique_name
		button.text = item  # Always use original text for display
		navbar_container.add_child(button)
		
		# Handle VBox container
		var existing_vbox = $DynamicMenu.get_node_or_null(str(i))
		if not existing_vbox:
			var vbox = VBoxContainer.new()
			vbox.name = str(i)
			vbox.layout_mode = 1
			vbox.set_anchors_preset(Control.PRESET_HCENTER_WIDE)
			$DynamicMenu.add_child(vbox)
			existing_vbox = vbox
		
		# Update visibility
		existing_vbox.visible = (i == 0)
	
	# Clean up unused VBox containers
	for i in range(new_links.size(), old_links.size()):
		var old_vbox = $DynamicMenu.get_node_or_null(str(i))
		if old_vbox:
			old_vbox.queue_free()

# Updates menu items when links change, minimizing recreations
func update_menu_links(old_links: Array, new_links: Array) -> void:
	# Update existing or create new items
	for i in new_links.size():
		var new_item = new_links[i]
		var vbox = get_node_or_null("DynamicMenu/" + str(i))
		
		if not vbox:
			continue
		
		# Remove all existing buttons
		for child in vbox.get_children():
			child.queue_free()
		
		# Process new items
		if new_item is PackedStringArray:
			for j in new_item.size():
				var menu_item = new_item[j]
				var unique_name = _get_unique_button_name(menu_item, j)
				var button = Button.new()
				button.name = unique_name
				button.text = menu_item  # Always use original text for display
				vbox.add_child(button)
		else:
			# Single item case
			var button = Button.new()
			var unique_name = _get_unique_button_name(str(new_item), 0)
			button.name = unique_name
			button.text = str(new_item)  # Always use original text for display
			vbox.add_child(button)
	
	# Clean up excess VBox containers
	for i in range(new_links.size(), old_links.size()):
		var old_vbox = $DynamicMenu.get_node_or_null(str(i))
		if old_vbox:
			old_vbox.queue_free()

# Helper function to generate unique button names
func _get_unique_button_name(base_name: String, index: int) -> String:
	# Add index to ensure uniqueness while preserving the original name for display
	return base_name + "_" + str(index)

#region: Enter/Exit
# Called when node enters scene tree
# Creates initial menu structure if it doesn't exist
func _enter_tree() -> void:
	_instance = DYNAMIC_MENU_SCENE.instantiate()
	add_child(_instance) # _instance = /root/Main/DynamicMenu/DynamicMenu
	create_initial_menu()

# Cleanup when node exits scene tree
func _exit_tree() -> void:
	if _instance:
		_instance.queue_free()
#endregion
