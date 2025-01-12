extends Control

@export var navbar_links : PackedStringArray
@export var menu_links : Array
@export var navbar : bool = true
@export var header : bool = true
@export var menu : bool = true
@export var tooltip : bool = true
var vbox = VBoxContainer
var hbox = HBoxContainer
var button : Button
var path
var scene : PackedScene = preload("res://addons/godot_dynamic/scenes/dynamic_menu/dynamic_menu.tscn")

	#var path = str(menu1.get_path()) + "/" + menu_items[active_item]
	#var target_node = get_node(path)
	#target_node.add_theme_color_override("font_color", Color(1, 0, 0))

func _enter_tree():
	# Instance the scene
	add_child(scene.instantiate())
	
	if navbar_links:
		var value = 0
		for item in navbar_links:
			# Create buttons
			button = Button.new()
			#button.name = str(value)
			button.name = str(item)
			button.text = item
			$DynamicMenu/Panel/HBoxContainer.add_child(button)
			
			# Create vboxs
			vbox = VBoxContainer.new()
			vbox.name = str(value)
			vbox.layout_mode = 1
			vbox.set_anchors_preset(Control.PRESET_HCENTER_WIDE)
			$DynamicMenu.add_child(vbox)
			
			# Makes everything but the first nav item invisible
			if value != 0:
				path = "DynamicMenu/" + str(value) + "/"
				get_node(path).visible = false
			
			value += 1
	
	
	if menu_links:
		var value = 0
		for item in menu_links:
			path = "DynamicMenu/" + str(value) + "/"
				
			if item is PackedStringArray and item != null:
				for menu_items in item:
					button = Button.new()
					button.name = menu_items
					button.text = menu_items
					get_node(path).add_child(button)
			else:
				button = Button.new()
				button.text = str(item)  # Added str() conversion for non-string items
				get_node(path).add_child(button)
	
			value += 1
