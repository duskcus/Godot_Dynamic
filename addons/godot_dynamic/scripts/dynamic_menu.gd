@tool
extends Control

var test : PackedScene = preload("res://addons/godot_dynamic/scenes/dynamic_menu/dynamic_menu.tscn")

func _enter_tree():
	# Instance the scene
	add_child(test.instantiate())
