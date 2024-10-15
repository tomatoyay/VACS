extends Node2D

# Declare member variables here. Examples:
var letter_finished = 0
onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")

onready var doc_anim = $Factory_Background/Letter_Animation
onready var animation = $Factory_Background/RejectionLetter/Letter1_Button/Letter1_Animation
onready var anim2 = $Factory_Background/RejectionLetter/Letter2_Button/Letter2_Animation
onready var anim3 = $Factory_Background/RejectionLetter/Letter3_Button/Letter3_Animation
onready var anim4 = $Factory_Background/RejectionLetter/Letter4_Button/Letter4_Animation
onready var anim5 = $Factory_Background/RejectionLetter/Letter5_Button/Letter5_Animation
onready var anim6 = $Factory_Background/RejectionLetter/Letter6_Button/Letter6_Animation
onready var anim7 = $Factory_Background/RejectionLetter/Letter7_Button/Letter7_Animation
onready var anim8 = $Factory_Background/RejectionLetter/Letter8_Button/Letter8_Animation


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func letter_finish():
	if letter_finished == 8:
		doc_anim.play("Document_Hide")
		yield(doc_anim,"animation_finished")
		var dialog = Dialogic.start("Day 1 Apothecary")
		dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(get_tree().create_timer(1.0), "timeout")
		MenusContainer.get_node('InGameMenu').show()
		add_child(dialog)


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

#Letter1
func _on_Letter1_Button_mouse_entered():
	animation.play("Letter1_Animation")

func _on_Letter1_Button_mouse_exited():
	animation.play("Letter1_Close")

func _on_Letter1_Button_pressed():
	var dialog = Dialogic.start("Letter 1")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter1_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()
	
	#Letter2
func _on_Letter2_Button_mouse_entered():
	anim2.play("Letter2_Show")

func _on_Letter2_Button_mouse_exited():
	anim2.play("Letter2_Hide")

func _on_Letter2_Button_pressed():
	var dialog = Dialogic.start("Letter 2")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter2_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()

#Letter3
func _on_Letter3_Button_mouse_entered():
	anim3.play("Letter3_Show")

func _on_Letter3_Button_mouse_exited():
	anim3.play("Letter3_Hide")

func _on_Letter3_Button_pressed():
	var dialog = Dialogic.start("Letter 3")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter3_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()

#Letter4
func _on_Letter4_Button_mouse_entered():
	anim4.play("Letter4_Show")

func _on_Letter4_Button_mouse_exited():
	anim4.play("Letter4_Hide")

func _on_Letter4_Button_pressed():
	var dialog = Dialogic.start("Letter 4")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter4_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()

#Letter5
func _on_Letter5_Button_mouse_entered():
	anim5.play("Letter5_Show")

func _on_Letter5_Button_mouse_exited():
	anim5.play("Letter5_Hide")

func _on_Letter5_Button_pressed():
	var dialog = Dialogic.start("Letter 3")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter5_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()

#Letter6
func _on_Letter6_Button_mouse_entered():
	anim6.play("Letter6_Show")

func _on_Letter6_Button_mouse_exited():
	anim6.play("Letter6_Hide")

func _on_Letter6_Button_pressed():
	var dialog = Dialogic.start("Letter 5")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter6_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()
	
#Letter7
func _on_Letter7_Button_mouse_entered():
	anim7.play("Letter7_Show")

func _on_Letter7_Button_mouse_exited():
	anim7.play("Letter7_Hide")

func _on_Letter7_Button_pressed():
	var dialog = Dialogic.start("Letter 6")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter7_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()

#Letter8
func _on_Letter8_Button_mouse_entered():
	anim8.play("Letter8_Show")

func _on_Letter8_Button_mouse_exited():
	anim8.play("Letter8_Hide")

func _on_Letter8_Button_pressed():
	var dialog = Dialogic.start("Letter 7")
	add_child(dialog)
	$Factory_Background/RejectionLetter/Letter8_Button.visible = false
	dialog.connect("timeline_end", self, 'after_dialog')
	yield(dialog,'timeline_end')
	letter_finished += 1
	letter_finish()
