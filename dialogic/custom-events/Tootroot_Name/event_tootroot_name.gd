extends Node

var tootroot_name: String = ""
onready var InputName = load("res://dialogic/custom-events/Tootroot_Name/InputName.tscn")
onready var MenusContainer = get_node("/root/MainScene/DialogicVisualNovelManager/Menus/MenuContainer")

func _ready():
	pass

func handle_event(_event_data, dialog_node):
	
	dialog_node.emit_signal("auto_skip_toggled", false)
	MenusContainer._on_Skip_Button_toggled(false)
	MenusContainer.get_node("InGameMenu/Auto_Button").disabled = true
	dialog_node.emit_signal("auto_advance_toggled", false)
	MenusContainer._on_Auto_Button_toggled(false)
	MenusContainer.get_node("InGameMenu/Skip_Button").disabled = true
	dialog_node.autoPlayMode = false
	dialog_node.autoSkipMode = false
	
	var input_name = InputName.instance()
	dialog_node.add_child(input_name)
	dialog_node.set_state(dialog_node.state.WAITING_INPUT)
	
		# Show the LineEdit for input
	input_name.visible = true
	input_name.get_node("Name Box/LineEdit").grab_focus() # Focus the LineEdit for typing
	
	# Connect the text_entered signal to handle the input
	input_name.get_node("Name Box/LineEdit").connect("text_entered", self, "_on_LineEdit_text_entered", [input_name, dialog_node])


func _on_LineEdit_text_entered(new_text, input_name, dialog_node):
	# This function is called when the player presses Enter in the LineEdit
	tootroot_name = new_text.strip_edges()
	print(tootroot_name)
	Dialogic.set_variable('tootroot',tootroot_name)
	print("Name entered:", tootroot_name)
	
	# Remove the input box after entering the name
	input_name.queue_free()

	# Continue with the dialogue
	dialog_node._load_next_event()
	MenusContainer.get_node("InGameMenu/Auto_Button").disabled = false
	MenusContainer.get_node("InGameMenu/Skip_Button").disabled = false
	dialog_node.set_state(dialog_node.state.READY)
	
