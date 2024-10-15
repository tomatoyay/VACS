extends Node

onready var QuickWit = load("res://dialogic/custom-events/Quick Wit/Quick_Wit.tscn")
#onready var quick_wit = QuickWit.instance()

# Declare a timer variable
var countdown_time
var timer
var finished = false
var event
var dialog
var default_option = {}

var quick_wit
var progress
var sound
var anim


func handle_event(event_data, dialog_node):
	countdown_time = 8.0
	timer = countdown_time
	finished = false

	quick_wit = QuickWit.instance()
	progress = quick_wit.get_node("Timer/Countdown")
	sound = quick_wit.get_node("Ding")
	anim = quick_wit.get_node("Animation")
	
	progress.value = 100
	dialog_node.autoPlayMode = false
	dialog_node.autoSkipMode = false
	
	# Initialize the TextureProgress node
	dialog_node.add_child(quick_wit)
	quick_wit.visible = true
	
	set_process(true)
	anim.play("Shake")
	
	for option in event_data['options']:
		if option['default'] == true:
			default_option = option
	
	dialog = dialog_node
	event = event_data
	#dialog_node._load_next_event()
	#dialog_node.set_state(dialog_node.state.READY)

func _ready():
	# Set the initial progress value to 100%
	#Start the countdown
	set_process(false)
	

func _process(delta):
	# Decrease the timer
	timer -= delta
	
	# Update the TextureProgress value
	progress.value = (timer / countdown_time) * progress.max_value
	# Stop the process when the countdown ends
	if progress.value <= 0:
		#sound.play()
		timer = 0
		set_process(false)
		progress.value = 0
		# Optionally, emit a signal or call a method when the timer ends
		_on_timer_finished(dialog, default_option)

func _on_timer_finished(dialog_node, choice):
	yield(get_tree().create_timer(0.3), "timeout")
	anim.play("RESET")
	set_process(false)
	quick_wit.visible = false
	dialog_node.answer_quick_wit_question(choice["event_idx"], choice["question_idx"], choice["label"])

func _on_default_wit(_event_data, dialog_node):
	anim.play("RESET")
	set_process(false)
	quick_wit.visible = false
	dialog_node._load_next_event()
	dialog_node.set_state(dialog_node.state.READY)


func stop_event(_event_data, dialog_node):
	anim.play("RESET")
	set_process(false)
	quick_wit.visible = false
	dialog_node._load_next_event()
	dialog_node.set_state(dialog_node.state.READY)
