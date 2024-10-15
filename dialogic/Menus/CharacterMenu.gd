extends Control

export(String) var starting_timeline = "Introduction"
#onready var intro

onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")
onready var from_character_menu = 0

################################################################################
##								PUBLIC
################################################################################

func open():
	if GlobalVariables.true_ending == 1 and GlobalVariables.endings > 0:
		$OrvenTrue_Control.visible = true
		$OrvenZanry_Control.visible = false
		$OrvenEnd_Control.visible = false
		$OrvenName.visible = false
		$OrvenNameGold.visible = false
#		$PC_Background.visible = false
		$Etisia.visible = true
		$Minerva.visible = true
		$Ives.visible = true
		$Meldan.visible = true
		$Gou.visible = true
		$Orven_Endings.visible = true
		$Orven_Endings/Ending6.disabled = true
		if GlobalVariables.orven_ending2 == 1:
			$Orven_Endings/Ending3.disabled = true
		if GlobalVariables.orven_ending3 == 1:
			$Orven_Endings/Ending5.disabled = true
		if GlobalVariables.orven_ending4 == 1:
			$Orven_Endings/Ending4.disabled = true
		if GlobalVariables.orven_ending5 == 1:
			$Orven_Endings/Ending1.disabled = true
		if GlobalVariables.orven_ending6 == 1:
			$Orven_Endings/Ending2.disabled = true
	elif GlobalVariables.true_ending != 1 and GlobalVariables.endings > 0:
		$OrvenZanry_Control.visible = false
		$OrvenEnd_Control.visible = true
		$OrvenTrue_Control.visible = false
#		$PC_Background.visible = false
		$Etisia.visible = true
		$Minerva.visible = true
		$Ives.visible = true
		$Meldan.visible = true
		$Gou.visible = true
		$OrvenName.visible = false
		$OrvenNameGold.visible = false
		$Orven_Endings.visible = true
		if GlobalVariables.orven_ending2 == 1:
			$Orven_Endings/Ending3.disabled = true
		if GlobalVariables.orven_ending3 == 1:
			$Orven_Endings/Ending5.disabled = true
		if GlobalVariables.orven_ending4 == 1:
			$Orven_Endings/Ending4.disabled = true
		if GlobalVariables.orven_ending5 == 1:
			$Orven_Endings/Ending1.disabled = true
		if GlobalVariables.orven_ending6 == 1:
			$Orven_Endings/Ending2.disabled = true
	else:
		pass
	show()
	yield(get_tree().create_timer(0.2), "timeout")
	$Back_Button.grab_focus()

################################################################################
##								PRIVATE
################################################################################

func _ready():
	open()
	$Back_Button.grab_focus()

func _on_OrvenZanry_pressed():
	if MenusContainer.get_node("MainMenu").new_game == 1:
		var intro
		if intro != null:
			intro.queue_free()
			intro = null
		intro = Dialogic.start(starting_timeline)
		MenusContainer.get_node("MenuMusic").playing = false
		intro.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(get_tree().create_timer(1.0), "timeout")
		intro.layer = 1
		MenusContainer.add_main_game_node(intro)
		MenusContainer.get_node("MainMenu").settings_menu = 0
		MenusContainer.get_node("MainMenu").quit_menu = 0
		MenusContainer.get_node("MainMenu").new_game = 0
		hide()
	elif GlobalVariables.save == false:
		var intro
		if intro != null:
			intro.queue_free()
			intro = null
		intro = Dialogic.start(starting_timeline)
		MenusContainer.get_node("MenuMusic").playing = false
		intro.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(get_tree().create_timer(1.0), "timeout")
		intro.layer = 1
		MenusContainer.add_main_game_node(intro)
		MenusContainer.get_node("MainMenu").settings_menu = 0
		MenusContainer.get_node("MainMenu").quit_menu = 0
		MenusContainer.get_node("MainMenu").new_game = 0
		hide()
	else:
		get_parent().get_parent().open_load_menu()
		from_character_menu = 1
	
func _on_OrvenZanry_mouse_entered():
	$ChapterSelection.visible = false
	$OrvenName.visible = true

func _on_OrvenZanry_mouse_exited():
	$OrvenName.visible = false
	$ChapterSelection.visible = true

func _on_OrvenEnd_mouse_entered():
	$ChapterSelection.visible = false
	$OrvenName.visible = true

func _on_OrvenEnd_mouse_exited():
	$OrvenName.visible = false
	$ChapterSelection.visible = true

func _on_OrvenTrue_mouse_entered():
	$ChapterSelection.visible = false
	$OrvenNameGold.visible = true

func _on_OrvenTrue_mouse_exited():
	$OrvenNameGold.visible = false
	$ChapterSelection.visible = true

#Etisia
func _on_Etisia_mouse_entered():
	$ChapterSelection.visible = false
	$EtisiaName.visible = true

func _on_Etisia_mouse_exited():
	$EtisiaName.visible = false
	$ChapterSelection.visible = true

#Minerva
func _on_Minerva_mouse_entered():
	$ChapterSelection.visible = false
	$MinervaName.visible = true

func _on_Minerva_mouse_exited():
	$MinervaName.visible = false
	$ChapterSelection.visible = true

#Ives
func _on_Ives_mouse_entered():
	$ChapterSelection.visible = false
	$IvesName.visible = true

func _on_Ives_mouse_exited():
	$IvesName.visible = false
	$ChapterSelection.visible = true

#Meldan
func _on_Meldan_mouse_entered():
	$ChapterSelection.visible = false
	$MeldanName.visible = true

func _on_Meldan_mouse_exited():
	$MeldanName.visible = false
	$ChapterSelection.visible = true

#Gou
func _on_Gou_mouse_entered():
	$ChapterSelection.visible = false
	$GouName.visible = true

func _on_Gou_mouse_exited():
	$GouName.visible = false
	$ChapterSelection.visible = true

func _on_dialogic_signal(argument:String):
	MenusContainer._on_Auto_Button_toggled(false)
	MenusContainer._on_Skip_Button_toggled(false)
	if argument == "Map0":
		var scene = load("res://Map/Map.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Tootroot0":
		var scene = load("res://Tootroot/Tootroot0.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
	elif argument == "rejection_letter":
		var scene = load("res://Rejection_Letter/Rejection_Letter.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Map1":
		var scene = load("res://Map/Map1.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == 'Sion_Hallway_Odiche':
		var scene = load("res://Hallway/Hallway_Miss_Odiche.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == 'Sion_Hallway_Herb':
		var scene = load("res://Hallway/Hallway_Herb.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Sion_Office":
		var scene = load("res://Gungand_Office/Gungand_Office.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Church_Door":
		var scene = load("res://Church_door.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false
	elif argument == "Credits":
		var scene = load("res://GodotCredits.tscn")
		var instance = scene.instance()
		MenusContainer.add_scene_node(instance)
		MenusContainer.get_node("MenuMusic").playing = false


func _on_Back_Button_pressed():
	MenusContainer.get_node("MainMenu").new_game = 0
	hide()
	get_parent().get_parent().open_main_menu()


func _on_Ending1_mouse_entered():
	$Orven_Endings/Ending1/Label1.visible = true

func _on_Ending1_mouse_exited():
	$Orven_Endings/Ending1/Label1.visible = false

func _on_Ending2_mouse_entered():
	$Orven_Endings/Ending2/Label2.visible = true

func _on_Ending2_mouse_exited():
	$Orven_Endings/Ending2/Label2.visible = false
	
func _on_Ending3_mouse_entered():
	$Orven_Endings/Ending3/Label3.visible = true

func _on_Ending3_mouse_exited():
	$Orven_Endings/Ending3/Label3.visible = false

func _on_Ending4_mouse_entered():
	$Orven_Endings/Ending4/Label4.visible = true

func _on_Ending4_mouse_exited():
	$Orven_Endings/Ending4/Label4.visible = false

func _on_Ending5_mouse_entered():
	$Orven_Endings/Ending5/Label5.visible = true

func _on_Ending5_mouse_exited():
	$Orven_Endings/Ending5/Label5.visible = false

func _on_Ending6_mouse_entered():
	$Orven_Endings/Ending6/Label6.visible = true

func _on_Ending6_mouse_exited():
	$Orven_Endings/Ending6/Label6.visible = false


func _on_OrvenTrue_pressed():
	if MenusContainer.get_node("MainMenu").new_game == 1:
		var intro
		if intro != null:
			intro.queue_free()
			intro = null
		intro = Dialogic.start(starting_timeline)
		MenusContainer.get_node("MenuMusic").playing = false
		intro.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(get_tree().create_timer(1.0), "timeout")
		intro.layer = 1
		MenusContainer.add_main_game_node(intro)
		MenusContainer.get_node("MainMenu").settings_menu = 0
		MenusContainer.get_node("MainMenu").quit_menu = 0
		MenusContainer.get_node("MainMenu").new_game = 0
		hide()
	else:
		get_parent().get_parent().open_load_menu()
		from_character_menu = 1


func _on_OrvenEnd_pressed():
	if MenusContainer.get_node("MainMenu").new_game == 1:
		var intro
		if intro != null:
			intro.queue_free()
			intro = null
		intro = Dialogic.start(starting_timeline)
		MenusContainer.get_node("MenuMusic").playing = false
		intro.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(get_tree().create_timer(1.0), "timeout")
		intro.layer = 1
		MenusContainer.add_main_game_node(intro)
		MenusContainer.get_node("MainMenu").settings_menu = 0
		MenusContainer.get_node("MainMenu").quit_menu = 0
		MenusContainer.get_node("MainMenu").new_game = 0
		hide()
	else:
		get_parent().get_parent().open_load_menu()
		from_character_menu = 1
