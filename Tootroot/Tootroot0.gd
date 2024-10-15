extends Node2D

# Declare member variables here. Examples:
var mouse_over = false
var tootroot_count = 0
onready var sink_anim = $OrvenApartment/Sink/Sink_Animation
onready var cupboard_anim = $OrvenApartment/Cupboards/Cupboard_Anim
onready var counter_anim = $OrvenApartment/Counter/Counter_Anim
onready var bed_anim = $OrvenApartment/Bed/Bed_Anim
onready var carpet_anim = $OrvenApartment/Carpet/Carpet_Anim
onready var table_anim = $OrvenApartment/Table/Table_Anim
onready var door_anim = $OrvenApartment/Door/Door_Anim
onready var phonograph_anim = $OrvenApartment/Phonograph/Phonograph_Anim
onready var iron_anim = $OrvenApartment/IronBoard/Iron_Anim
onready var photo_anim = $OrvenApartment/Photo/Photo_Anim
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
	$Orven_Home_Music.playing = true
	$Orven_Home_Anim.play("Orven_Home_Transition")
	yield(get_tree().create_timer(1.0), "timeout")
	var dialog = Dialogic.start("Tootroot Intro")
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


func _on_Sink_mouse_entered():
	mouse_over = true
	sink_anim.play("Sink_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Sink_mouse_exited():
	mouse_over = false
	sink_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Sink_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Tootroot 0")
		MenusContainer.get_node('InGameMenu').show()
		fade_out($Orven_Home_Music)
		add_child(dialog)
		dialog.connect("dialogic_signal", self, "_on_dialogic_signal")
		yield(dialog,'timeline_end')
		$OrvenApartment/Sink.visible = false

func _on_Cupboards_mouse_entered():
	mouse_over = true
	cupboard_anim.play("Cupboard_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Cupboards_mouse_exited():
	mouse_over = false
	cupboard_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Cupboards_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Cupboards_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Cupboards.visible = false

func _on_Counter_mouse_entered():
	mouse_over = true
	counter_anim.play("Counter_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Counter_mouse_exited():
	mouse_over = false
	counter_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Counter_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Counter_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Counter.visible = false

func _on_Bed_mouse_entered():
	mouse_over = true
	bed_anim.play("Bed_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Bed_mouse_exited():
	mouse_over = false
	bed_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Bed_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Bed_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Bed.visible = false

func _on_Carpet_mouse_entered():
	mouse_over = true
	carpet_anim.play("Carpet_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Carpet_mouse_exited():
	mouse_over = false
	carpet_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Carpet_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Carpet_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Carpet.visible = false
		
func _on_Table_mouse_entered():
	mouse_over = true
	table_anim.play("Table_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Table_mouse_exited():
	mouse_over = false
	table_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Table_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Table_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Table.visible = false

func _on_Door_mouse_entered():
	mouse_over = true
	door_anim.play("Door_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Door_mouse_exited():
	mouse_over = false
	door_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Door_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Door_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Door.visible = false

func _on_Phonograph_mouse_entered():
	mouse_over = true
	phonograph_anim.play("Phonograph_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Phonograph_mouse_exited():
	mouse_over = false
	phonograph_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Phonograph_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Phonograph_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Phonograph.visible = false

func _on_IronBoard_mouse_entered():
	mouse_over = true
	iron_anim.play("Iron_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_IronBoard_mouse_exited():
	mouse_over = false
	iron_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_IronBoard_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Ironing Board")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/IronBoard.visible = false

func _on_Photo_mouse_entered():
	mouse_over = true
	photo_anim.play("Photo_Hover")
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_Photo_mouse_exited():
	mouse_over = false
	photo_anim.play("RESET")
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_Photo_input_event(_viewport, event, _shape_idx):
	if mouse_over and event.is_pressed() and event.button_index == BUTTON_LEFT:
		var dialog = Dialogic.start("Photo_Tootroot")
		add_child(dialog)
		yield(dialog,'timeline_end')
		$OrvenApartment/Photo.visible = false
