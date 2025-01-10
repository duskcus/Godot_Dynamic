@tool
extends TextureRect

var test : Texture = preload("res://addons/assets/menu.svg")

# Initialization of the plugin goes here.
func _enter_tree() -> void:
	texture.draw(test, Vector2(0, 0))


# Clean-up of the plugin goes here.
func clicked() -> void:
	return
