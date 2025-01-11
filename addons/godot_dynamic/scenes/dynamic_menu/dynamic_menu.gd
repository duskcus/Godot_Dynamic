extends Control

@export var navbar_items = ["Offline", "Online", "Profile", "Market", "Settings"]
var vbox = VBoxContainer.new()
var hbox = HBoxContainer.new()
var button : Button
var value = 0

func _ready(): # This function will be called when the node is added to the scene
	for item in navbar_items:
		button = Button.new()
		button.text = navbar_items[value]
		$Panel/HBoxContainer.add_child(button)
		value += 1
