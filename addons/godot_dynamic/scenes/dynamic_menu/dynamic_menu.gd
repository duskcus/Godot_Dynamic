extends Control

@export var navbar_items = ["Offline", "Online", "Profile", "Market", "Settings"]
@export var menu_items = ["Offline", "Online", "Profile", "Market", "Settings"]
@export var navbar : bool = true
@export var header : bool = true
@export var menu : bool = true
@export var tooltip : bool = true
var vbox = VBoxContainer
var hbox = HBoxContainer
var button : Button
var value = 0

func _ready(): # This function will be called when the node is added to the scene
	for item in navbar_items:
		button = Button.new()
		button.text = navbar_items[value]
		$Panel/HBoxContainer.add_child(button)
		value += 1
	
	value = 0
	
	for item in menu_items:
		button = Button.new()
		button.text = menu_items[value]
		$VBoxContainer.add_child(button)
		value += 1
