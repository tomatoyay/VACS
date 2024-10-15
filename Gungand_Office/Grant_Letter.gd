extends Node

# Declare member variables here. Examples:
var g_letter_finished = 0
onready var grant_anim = $Grant_Letter_Animation
onready var ganim = $Letter1_Button/Letter1_Animation
onready var ganim2 = $Letter2_Button/Letter2_Animation
onready var ganim3 = $Letter3_Button/Letter3_Animation
onready var ganim4 = $Letter4_Button/Letter4_Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func g_letter_finish():
	if g_letter_finished == 4:
		grant_anim.play("RESET")
		yield(grant_anim,"animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		var dialog = Dialogic.start("G_Letter_Outro")
		add_child(dialog)
		yield(dialog,'timeline_end')
		get_parent().get_parent().office_finish()
		get_parent().visible = false

#Letter1
func _on_Letter1_Button_mouse_entered():
	ganim.play("Letter1_Animation")

func _on_Letter1_Button_mouse_exited():
	ganim.play("RESET")

func _on_Letter1_Button_pressed():
	var dialog = Dialogic.start("GLetter_1")
	add_child(dialog)
	$Letter1_Button.visible = false
	yield(dialog,'timeline_end')
	g_letter_finished += 1
	g_letter_finish()
	
	#Letter2
func _on_Letter2_Button_mouse_entered():
	ganim2.play("Letter2_Show")

func _on_Letter2_Button_mouse_exited():
	ganim2.play("RESET")

func _on_Letter2_Button_pressed():
	var dialog = Dialogic.start("GLetter_2")
	add_child(dialog)
	$Letter2_Button.visible = false
	yield(dialog,'timeline_end')
	g_letter_finished += 1
	g_letter_finish()

#Letter3
func _on_Letter3_Button_mouse_entered():
	ganim3.play("Letter3_Show")

func _on_Letter3_Button_mouse_exited():
	ganim3.play("RESET")

func _on_Letter3_Button_pressed():
	var dialog = Dialogic.start("GLetter_3")
	add_child(dialog)
	$Letter3_Button.visible = false
	yield(dialog,'timeline_end')
	g_letter_finished += 1
	g_letter_finish()

#Letter4
func _on_Letter4_Button_mouse_entered():
	ganim4.play("Letter4_Show")

func _on_Letter4_Button_mouse_exited():
	ganim4.play("RESET")

func _on_Letter4_Button_pressed():
	var dialog = Dialogic.start("GLetter_4")
	add_child(dialog)
	$Letter4_Button.visible = false
	yield(dialog,'timeline_end')
	g_letter_finished += 1
	g_letter_finish()

