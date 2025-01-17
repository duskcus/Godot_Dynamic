@tool
extends Button

@export var test : Array

func _enter_tree():
	print("You clicked me!")


func clicked():
	print("You clicked me!")
