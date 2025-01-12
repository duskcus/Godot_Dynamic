@tool
extends Control

#region vars
@export var navbar_items : Array
@export var menu_items : Array
@export var navbar : bool = true
@export var header : bool = true
@export var menu : bool = true
@export var tooltip : bool = true
var vbox = VBoxContainer
var hbox = HBoxContainer
var button : Button
var value = 0
var scene : PackedScene = preload("res://addons/godot_dynamic/scenes/dynamic_menu/dynamic_menu.tscn")
#endregion

func _enter_tree():
	# Instance the scene
	add_child(scene.instantiate())
	
	if navbar_items:
		for item in navbar_items:
			button = Button.new()
			button.text = navbar_items[value]
			$DynamicMenu/Panel/HBoxContainer.add_child(button)
			value += 1
	
	value = 0
	
	if menu_items:
		for item in menu_items:
			button = Button.new()
			button.text = menu_items[value]
			$DynamicMenu/VBoxContainer.add_child(button)
			value += 1
