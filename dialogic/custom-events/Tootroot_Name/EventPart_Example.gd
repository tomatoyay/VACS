tool
extends "res://addons/dialogic/Editor/Events/Parts/EventPart.gd"
 # has an event_data variable that stores the current data!!!


 # used to connect the signals
func _ready():	
	pass

 # called by the event block
func load_data(data:Dictionary):	
		# First set the event_data
	.load_data(data)

 # has to return the wanted preview, only useful for body parts
func get_preview():
	return ''

