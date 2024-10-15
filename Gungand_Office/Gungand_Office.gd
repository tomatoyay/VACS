extends Node2D

# Declare member variables here. Examples:
var mouse_over = false
var office_count = 0
var babs_letter = 0
onready var bookshelf_anim = $SionOffice/Bookshelf/Bookshelf_Animation
onready var calendar_anim = $SionOffice/Calendar/Calendar_Animation
onready var right_drawer_anim = $SionOffice/Right_Drawer/Right_Drawer_Animation
onready var left_drawer_anim = $SionOffice/Left_Drawer/Left_Drawer_Animation
onready var garbage_anim = $SionOffice/Garbage/Garbage_Animation
onready var floor_anim = $SionOffice/Floor/Floor_Animation
onready var control = $Documents
onready var fade_anim = $FadeAnim
onready var tween_out = get_node("Tween")
export var transition_duration = 4.00
export var transition_type = 1 # TRANS_SINE
onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")

func fade_out(stream_player):
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped

func _on_TweenOut_tween_completed(object, _key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()

# Called when the node enters the scene tree for the first time.
func _ready():
	fade_anim.play("RESET")
	$Sion_Office_Music.playing = true
	yield(get_tree().create_timer(1.0), "timeout")
	var dialog = Dialogic.start("Office Intro")
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
	elif argument == "Fade":
		var dialog = Dialogic.start("Office Intro 2")
		fade_anim.play("Fade In")
		yield(get_tree().create_timer(1.0), "timeout")
		dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
		add_child(dialog)
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

func office_finish():
	if Dialogic.get_variable('office') == '7':
		yield(get_tree().create_timer(0.5), "timeout")
		var dialog1 = Dialogic.start("Office End")
		dialog1.connect("dialogic_signal", self, "_on_dialogic_signal")
		MenusContainer.get_node('InGameMenu').show()
		yield(get_tree().create_timer(0.5), "timeout")
		$Sion_Office_Music.playing = false
		add_child(dialog1)


#Bookshelf
func _on_Bookshelf_mouse_entered():
	mouse_over = true
	bookshelf_anim.play("Bookshelf_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Bookshelf_mouse_exited():
	mouse_over = false
	bookshelf_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Bookshelf_input_event(_viewport, event, _shape_idx):
	var anim = $Documents/Church_Rejection_Letter/Church_Letter_Animation
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Bookshelf")
		add_child(dialog)
		yield(dialog,'timeline_end')
		if Dialogic.get_variable("church_letter") == "1":
			control.visible = true
			anim.play("Church_Letter")
			

#Calendar
func _on_Calendar_mouse_entered():
	mouse_over = true
	calendar_anim.play("Calendar_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Calendar_mouse_exited():
	mouse_over = false
	calendar_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Calendar_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Calendar")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$SionOffice/Calendar.visible = false
		office_finish()

#Right Drawer
func _on_Right_Drawer_mouse_entered():
	mouse_over = true
	right_drawer_anim.play("Right_Drawer_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Right_Drawer_mouse_exited():
	mouse_over = false
	right_drawer_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Right_Drawer_input_event(_viewport, event, _shape_idx):
	var anim = $Documents/Maud_Note/Maud_Note_Animation
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		control.visible = true
		anim.play("Maud_Note")
		$SionOffice/Right_Drawer.visible = false


#Left Drawer
func _on_Left_Drawer_mouse_entered():
	mouse_over = true
	left_drawer_anim.play("Left_Drawer_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Left_Drawer_mouse_exited():
	mouse_over = false
	left_drawer_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Left_Drawer_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Left Drawer")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$SionOffice/Left_Drawer.visible = false
		office_finish()


#Garbage
func _on_Garbage_mouse_entered():
	mouse_over = true
	garbage_anim.play("Garbage_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Garbage_mouse_exited():
	mouse_over = false
	garbage_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Garbage_input_event(_viewport, event, _shape_idx):
	var anim = $Documents/Throckmorton_Letter/Throck_Letter_Animation
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Garbage")
		add_child(dialog)
		yield(dialog,'timeline_end')
		if Dialogic.get_variable("jones_letters") == "1":
			control.visible = true
			anim.play("Throck_Letter")
			babs_letter = 1
			$SionOffice/Garbage.visible = false
		else:
			office_finish()
			$SionOffice/Garbage.visible = false

func start_Babs_letter():
	var anim = $Documents/Babinski_Letter/Babinski_Letter_Animation
	if babs_letter == 1:
		anim.play("Babinski_Letter")
		yield(anim,"animation_finished")

#Floor
func _on_Floor_mouse_entered():
	mouse_over = true
	floor_anim.play("Floor_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Floor_mouse_exited():
	mouse_over = false
	floor_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Floor_input_event(_viewport, event, _shape_idx):
	var anim = $Documents/Grant_Letter/Grant_Letter_Animation
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Floor")
		add_child(dialog)
		yield(dialog,'timeline_end')
		if Dialogic.get_variable("grant_letter") == "1":
			control.visible = true
			anim.play("Grant_Letter")
			$SionOffice/Floor.visible = false
