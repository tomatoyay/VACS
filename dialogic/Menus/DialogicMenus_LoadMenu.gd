extends Control

var SaveSlot = preload("res://dialogic/Menus/DialogicMenu_SaveSlot.tscn")

onready var SaveSlotContainer = $Scroll/SaveSlots
onready var MenusContainer = get_parent().get_parent().get_parent()

export (NodePath) var Game

var current_selected_slot

################################################################################
##								PUBLIC
################################################################################

func open() -> void:
	show()
	update_saves()
	
# will reload and add saves slots
func update_saves() -> void:
	for child in SaveSlotContainer.get_children():
		child.queue_free()
	for slot_name in Dialogic.get_slot_names():
		var x = SaveSlot.instance()
		x.set_name(slot_name)
		SaveSlotContainer.add_child(x)
		x.connect("pressed", self, "save_slot_pressed")
		x.connect("delete_requested", self , "save_slot_delete_request")


# will load the currently selected slot
func load_slot() -> void:
	get_parent().get_node("CharacterMenu").from_character_menu = 0
	get_parent().get_parent().current_menu = get_parent().get_node("LoadMenu")
	get_parent().get_parent().hide_current()
	Dialogic.load(current_selected_slot)
	var dialog = Dialogic.start()
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	yield(get_tree().create_timer(2), "timeout")
	MenusContainer.add_main_game_node(dialog)
	MenusContainer.resume_game()

################################################################################
##								PRIVATE
################################################################################

func _ready() -> void:
	hide()

# will load the slot @save_slot_name or show a warning
func save_slot_pressed(save_slot_name:String) -> void:
	current_selected_slot = save_slot_name
	if MenusContainer.is_game_playing() and not MenusContainer.current_saved:
		MenusContainer.LooseWarning.open(self, "load_slot")
	else:
		load_slot()

# will show a warning about deleting saves
func save_slot_delete_request(save_slot_name:String) -> void:
	current_selected_slot = save_slot_name
	MenusContainer.LooseSaveWarning.open(self, "delete_save_slot")

# will delete the currently selected save slot
func delete_save_slot() -> void:
	Dialogic.erase_slot(current_selected_slot)
	update_saves()

func _on_Chapter_Selection_pressed():
	if MenusContainer.is_game_playing() == true:
			MenusContainer.LooseWarning.open(get_parent().get_parent(), "open_character_menu")
	else:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_character_menu()

func _on_Back_pressed():
	if get_parent().get_node("CharacterMenu").from_character_menu == 1:
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_character_menu()
		get_parent().get_node("CharacterMenu").from_character_menu = 0
	else:
		print(get_parent().get_parent().current_menu)
		get_parent().get_parent().hide_current()
		get_parent().get_parent().open_navigation_menu()
		get_parent().get_parent().navigation_menu = true

func _on_Quit_pressed():
	get_parent().get_parent().open_quit_menu()

func _on_dialogic_signal(argument:String):
	MenusContainer._on_Auto_Button_toggled(false)
	MenusContainer._on_Skip_Button_toggled(false)
	if argument == "Map0":
		var scene = load("res://Map/Map.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "Tootroot0":
		var scene = load("res://Tootroot/Tootroot0.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "rejection_letter":
		var scene = load("res://Rejection_Letter/Rejection_Letter.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "Map1":
		var scene = load("res://Map/Map1.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == 'Sion_Hallway_Odiche':
		var scene = load("res://Hallway/Hallway_Miss_Odiche.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == 'Sion_Hallway_Herb':
		var scene = load("res://Hallway/Hallway_Herb.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "Sion_Office":
		var scene = load("res://Gungand_Office/Gungand_Office.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "Church_Door":
		var scene = load("res://Church_door.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "Credits":
		var scene = load("res://GodotCredits.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		
