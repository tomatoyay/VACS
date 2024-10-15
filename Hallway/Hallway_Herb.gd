extends Node2D

# Declare member variables here. Examples:
var mouse_over = false
onready var zoom_anim = $SionHallway/Zoomed_Button/Zoomed_Animation
onready var zoom_hallway = $SionHallway/ZoomedHallway/ZoomedHallwayAnimation
onready var carpet_anim = $SionHallway/Carpet_Area2D/Carpet_Animation
onready var radiator_anim = $SionHallway/Radiator_Area2D/Radiator_Animation
onready var lamp_anim = $SionHallway/Lamp_Area2D/Lamp_Animation
onready var window_anim = $SionHallway/ZoomedHallway/Window/Window_Animation
onready var painting_anim = $SionHallway/ZoomedHallway/Painting/Painting_Animation
onready var door_crack_anim = $SionHallway/ZoomedHallway/Door_Crack/Door_Crack_Animation
onready var doorknob_anim = $SionHallway/ZoomedHallway/Doorknob/Doorknob_Animation
onready var back_arrow_anim = $SionHallway/ZoomedHallway/BackArrow/BackArrow_Area2D/BackArrow_Animation
onready var fade_anim = $FadeAnim
onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")

# Called when the node enters the scene tree for the first time.
func _ready():
	$Background_Music.playing = true
	fade_anim.play("Fade In")
	yield(get_tree().create_timer(1.0), "timeout")
	var dialog = Dialogic.start("Hallway Herb")
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
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
	
#Zoomed In Hallway
func _on_Zoomed_Button_mouse_entered():
	zoom_anim.play("Zoomed_Animation")

func _on_Zoomed_Button_mouse_exited():
	zoom_anim.play("RESET")

func _on_Zoomed_Button_pressed():
	zoom_hallway.play("Zoomed_Hallway_In")
	yield(zoom_hallway,"animation_finished")
	$SionHallway/ZoomedHallway/BackArrow.visible = true
	$SionHallway/Zoomed_Button.disabled = true
	$SionHallway/Zoomed_Button.visible = false
	$SionHallway/ZoomedHallway.visible = true
	

#Carpet
func _on_Carpet_Area2D_mouse_entered():
	mouse_over = true
	carpet_anim.play("Carpet_Animation_On")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Carpet_Area2D_mouse_exited():
	mouse_over = false
	carpet_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Carpet_Area2D_input_event(_viewport,event,_shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Carpet-2")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$SionHallway/Carpet_Area2D.visible = false

#Radiator
func _on_Radiator_Area2D_mouse_entered():
	mouse_over = true
	radiator_anim.play("Radiator_Animation_On")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Radiator_Area2D_mouse_exited():
	mouse_over = false
	radiator_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)
	
func _on_Radiator_Area2D_input_event(_viewport,event,_shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Radiator-2")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$SionHallway/Radiator_Area2D.visible = false


#Lamp
func _on_Lamp_Area2D_mouse_entered():
	mouse_over = true
	lamp_anim.play("Lamp_Animation_On")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Lamp_Area2D_mouse_exited():
	mouse_over = false
	lamp_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Lamp_Area2D_input_event(_viewport,event,_shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Lamp-2")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$SionHallway/Lamp_Area2D.visible = false

#Window
func _on_Window_mouse_entered():
	window_anim.play("Window_Animation_On")

func _on_Window_mouse_exited():
	window_anim.play("RESET")

func _on_Window_pressed():
	var dialog = Dialogic.start("Window-2")
	add_child(dialog)
	yield(dialog,'timeline_end')
	$SionHallway/ZoomedHallway/Window.visible = false

#Painting
func _on_Painting_mouse_entered():
	painting_anim.play("Painting_Animation_On")

func _on_Painting_mouse_exited():
	painting_anim.play("RESET")

func _on_Painting_pressed():
	var dialog = Dialogic.start("Painting-2")
	add_child(dialog)
	yield(dialog,'timeline_end')
	$SionHallway/ZoomedHallway/Painting.visible = false

#Door Crack
func _on_Door_Crack_mouse_entered():
	door_crack_anim.play("Door_Crack_On")

func _on_Door_Crack_mouse_exited():
	door_crack_anim.play("RESET")

func _on_Door_Crack_pressed():
	var dialog = Dialogic.start("Door Crack-2")
	add_child(dialog)
	yield(dialog,'timeline_end')
	$SionHallway/ZoomedHallway/Door_Crack.visible = false

#Doorknob
func _on_Doorknob_mouse_entered():
	doorknob_anim.play("Doorknob_Animation")

func _on_Doorknob_mouse_exited():
	doorknob_anim.play("RESET")

func _on_Doorknob_pressed():
	var dialog = Dialogic.start("Doorknob-2")
	add_child(dialog)
	dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
	yield(dialog,'timeline_end')

#Back Arrow
func _on_BackArrow_Area2D_mouse_entered():
	mouse_over = true
	back_arrow_anim.play("BackArrow_Animation_On")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_BackArrow_Area2D_mouse_exited():
	mouse_over = false
	back_arrow_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_BackArrow_Area2D_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		$SionHallway/ZoomedHallway/BackArrow.visible = false
		zoom_hallway.play("Zoomed_Hallway_Out")
		$SionHallway/ZoomedHallway.visible = false
		$SionHallway/Zoomed_Button.visible = true
		$SionHallway/Zoomed_Button.disabled = false
