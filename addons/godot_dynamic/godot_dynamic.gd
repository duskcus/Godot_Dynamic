@tool
extends EditorPlugin


# Initialization of the plugin goes here.
func _enter_tree() -> void:
	# custom name, existing node, custom script, img for new node
	add_custom_type("DynamicMenu", "TextureRect", preload("res://addons/godot_dynamic/dynamic_menu.gd"), preload("res://addons/assets/menu.svg"))
 

# Clean-up of the plugin goes here.
func _exit_tree() -> void:
	remove_custom_type("DynamicMenu")
