tool
extends "res://addons/dialogic/Editor/Events/Parts/EventPart.gd"
 # has an event_data variable that stores the current data!!!

## node references
onready var input_field = $HBox/ChoiceText

# used to connect the signals
func _ready():
	input_field.connect("text_changed", self, "_on_ChoiceText_text_changed")
	
# called by the event block
func load_data(data:Dictionary):
	# First set the event_data
	.load_data(data)
		# Now update the ui nodes to display the data. 
	input_field.text = event_data['choice']
	
# has to return the wanted preview, only useful for body parts
func get_preview():
	return ''

func _on_ChoiceText_text_changed(text):
	event_data['choice'] = text
	
	# informs the parent about the changes!
	data_changed()

func check_data():
#	if event_data['condition'] != '==' and event_data['condition'] != '!=' and event_data['condition'] != '':
#		if not event_data['value'].is_valid_float():
#			emit_signal("set_warning", DTS.translate("The selected operator requires a number!"))
#			return
	
	emit_signal("remove_warning")
