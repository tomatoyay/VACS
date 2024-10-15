extends CanvasLayer

const CHAR_READ_RATE = 0.02

enum State {
	READY,
	READING,
	FINISHED,
	DONE
}
var current_state = State.READY
var text_queue = [] 

# Declare member variables here. Examples:
onready var textbox_container = $MarginContainer
onready var dialogue = $MarginContainer/HSplitContainer/Textbox/VSplitContainer/Dialogue/HSplitContainer/MarginContainer/Text
onready var next_indicator = $MarginContainer/HSplitContainer/Textbox/VSplitContainer/Dialogue/HSplitContainer/MarginContainer2/Next_indicator
onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Starting state: State.READY")
	animation.play("Dialogue_Box_Up")
	queue_text("'PPM'?")
	queue_text("Ahh, it's definitely a title for someone who deals with magic.")
	queue_text("...think...")
	queue_text("!!!")
	queue_text("Proficient in Potions and Magic, that's what that stands for.")
	queue_text("Nice nice, look who knows a little bit about magic!")

func _process(delta):
	match current_state:
		State.READY:
			if !text_queue.empty():
				display_text()
		State.READING:
			if Input.is_action_just_pressed("ui_accept"): 
				dialogue.percent_visible = 1.0
				$Tween.stop_all()
				next_indicator.show()
				change_state(State.FINISHED)
		State.FINISHED:
			if Input.is_action_just_pressed("ui_accept"): 
				change_state(State.READY)
				hide_textbox()
			if text_queue.empty():
				animation.play("Dialogue_Box_Down")
				change_state(State.DONE)
		State.DONE:
			pass
func queue_text(next_text):
	text_queue.push_back(next_text)

func hide_textbox():
	dialogue.text = ""
	textbox_container.hide()

func show_textbox():
	#animation.play("Dialogue_Box_Up")
	textbox_container.show()

func display_text():
	var next_text = text_queue.pop_front()
	dialogue.text = next_text
	dialogue.percent_visible = 0.0
	change_state(State.READING)
	show_textbox()
	$Tween.interpolate_property(dialogue, "percent_visible", 0.0, 1.0, len(next_text)*CHAR_READ_RATE, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Tween_tween_all_completed():
	next_indicator.show()
	change_state(State.FINISHED)

func change_state(next_state):
	current_state = next_state
	match current_state:
		State.READY:
			print("Changing state to: State.READY")
		State.READING:
			print("Changing state to: State.READING")
		State.FINISHED:
			print("Changing state to: State.FINISHED")
		State.DONE:
			print("Done.")
			
