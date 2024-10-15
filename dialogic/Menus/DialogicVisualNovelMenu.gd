extends Control

var auto_button = false

#global variables
onready var save = false #have they saved or not yet
onready var endings
onready var true_ending
onready var orven_ending2
onready var orven_ending3
onready var orven_ending4
onready var orven_ending5
onready var orven_ending6
onready var fullscreen

#mouse
onready var hand = load("res://art/Mouse Hand.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_custom_mouse_cursor(hand, Input.CURSOR_POINTING_HAND)
	save = file_exists("user://Save 0/thumbnail.png")
	if not file_exists("user://save_game.dat"):
		return # Error! We don't have a save to load.
	else:
		load_game()

func file_exists(file_path: String) -> bool:
	var file = File.new()
	var error = file.open(file_path, File.READ)
	if error == OK:
		file.close()
		return true
	return false


func save_data():
	fullscreen = OS.window_fullscreen
	var save_dict = {
		"endings" : endings,
		"true_ending" :true_ending,
		"orven_ending2" : orven_ending2,
		"orven_ending3" : orven_ending3,
		"orven_ending4" : orven_ending4,
		"orven_ending5" : orven_ending5,
		"orven_ending6" : orven_ending6,
		"fullscreen":fullscreen,
	}
	return save_dict

func save_game(data):
	var file = File.new()
	if file.open("user://save_game.dat", File.WRITE) == OK:
		file.store_string(to_json(data))
		file.close()
		print("Game saved successfully.")
	else:
		print("Failed to save game.")

func load_game():
	var file = File.new()
	if file.file_exists("user://save_game.dat") and file.open("user://save_game.dat", File.READ) == OK:
		var data = parse_json(file.get_as_text())
		if typeof(data) == TYPE_DICTIONARY:
			endings = data.get("endings", endings)
			true_ending = data.get("true_ending", true_ending)
			orven_ending2 = data.get("orven_ending2", orven_ending2)
			orven_ending3 = data.get("orven_ending3", orven_ending3)
			orven_ending4 = data.get("orven_ending4", orven_ending4)
			orven_ending5 = data.get("orven_ending5", orven_ending5)
			orven_ending6 = data.get("orven_ending6", orven_ending6)
			fullscreen = data.get("fullscreen",fullscreen)
			OS.window_fullscreen = fullscreen
			print("Game loaded successfully.")
			
		else:
			print("Failed to parse JSON.")
		file.close()
	else:
		print("Failed to load game.")
	


