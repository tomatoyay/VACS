tool
extends "res://addons/dialogic/Editor/Events/Parts/EventPart.gd"
 # has an event_data variable that stores the current data!!!

## node references
onready var input_field = $VBoxContainer/HBox/ChoiceText
onready var is_default_check = $VBoxContainer/HBox/Default/IsDefault
onready var condition_picker = $VBoxContainer/HBox/ConditionPicker

# used to connect the signals
func _ready():
	# e.g. 
	input_field.connect("text_changed", self, "_on_ChoiceText_text_changed")
	is_default_check.connect("toggled", self, "_on_IsDefault_toggled")
	condition_picker.connect("data_changed", self, "_on_ConditionPicker_data_changed")
	condition_picker.connect("remove_warning", self, "emit_signal", ["remove_warning"])
	condition_picker.connect("set_warning", self, "set_warning")
	
	
# called by the event block
func load_data(data:Dictionary):
	# First set the event_data
	.load_data(data)
	
	# Now update the ui nodes to display the data. 
	input_field.text = event_data['choice']

	# Loading the data on the selectors
	condition_picker.load_data(event_data)
		
	if event_data['default'] == false: # Checking if definition is selected
		is_default_check.pressed = false
	else:
		is_default_check.pressed = true

# has to return the wanted preview, only useful for body parts
func get_preview():
	return ''

func _on_ChoiceText_text_changed(text):
	event_data['choice'] = text
	
	data_changed()

func _on_IsDefault_toggled(checkbox_value):
	if checkbox_value == false:
		event_data['default'] = checkbox_value
	elif checkbox_value == true:
		event_data['default'] = checkbox_value
	
	data_changed()

func _on_ConditionPicker_data_changed(data):
	event_data = data
	
	data_changed()

func set_warning(text):
	emit_signal("set_warning", text)
