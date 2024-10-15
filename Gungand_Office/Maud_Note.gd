extends Node


# Declare member variables here. Examples:
var m_letter_finished = 0
onready var maud_anim = $Maud_Note_Animation
onready var manim = $Note_Button/Note_Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func m_letter_finish():
	if m_letter_finished == 1:
		maud_anim.play("RESET")
		yield(maud_anim,"animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		var dialog = Dialogic.start("M_Letter_Outro")
		add_child(dialog)
		yield(dialog,'timeline_end')
		get_parent().get_parent().office_finish()
		get_parent().visible = false

#Letter1
func _on_Note_Button_mouse_entered():
	manim.play("Note_Button_Animation")

func _on_Note_Button_mouse_exited():
	manim.play("RESET")

func _on_Note_Button_pressed():
	var dialog = Dialogic.start("MLetter_1")
	add_child(dialog)
	$Note_Button.visible = false
	yield(dialog,'timeline_end')
	m_letter_finished += 1
	m_letter_finish()
	
