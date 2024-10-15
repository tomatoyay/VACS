extends Node


# Declare member variables here. Examples:
var b_letter_finished = 0
onready var babs_anim = $Babinski_Letter_Animation
onready var banim = $Letter1_Button/Letter1_Animation
onready var banim2 = $Letter2_Button/Letter2_Animation
onready var banim3 = $Letter3_Button/Letter3_Animation
onready var banim4 = $Letter4_Button/Letter4_Animation
onready var banim5 = $Letter5_Button/Letter5_Animation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func b_letter_finish():
	if b_letter_finished == 5:
		babs_anim.play("RESET")
		yield(babs_anim,"animation_finished")
		yield(get_tree().create_timer(0.5), "timeout")
		var dialog = Dialogic.start("B_Letter_Outro")
		add_child(dialog)
		yield(dialog,'timeline_end')
		get_parent().get_parent().office_finish()
		get_parent().visible = false

#Letter1
func _on_Letter1_Button_mouse_entered():
	banim.play("Letter1_Animation")

func _on_Letter1_Button_mouse_exited():
	banim.play("RESET")

func _on_Letter1_Button_pressed():
	var dialog = Dialogic.start("BLetter_1")
	add_child(dialog)
	$Letter1_Button.visible = false
	yield(dialog,'timeline_end')
	b_letter_finished += 1
	b_letter_finish()
	
	#Letter2
func _on_Letter2_Button_mouse_entered():
	banim2.play("Letter2_Show")

func _on_Letter2_Button_mouse_exited():
	banim2.play("RESET")

func _on_Letter2_Button_pressed():
	var dialog = Dialogic.start("BLetter_2")
	add_child(dialog)
	$Letter2_Button.visible = false
	yield(dialog,'timeline_end')
	b_letter_finished += 1
	b_letter_finish()

#Letter3
func _on_Letter3_Button_mouse_entered():
	banim3.play("Letter3_Show")

func _on_Letter3_Button_mouse_exited():
	banim3.play("RESET")

func _on_Letter3_Button_pressed():
	var dialog = Dialogic.start("BLetter_3")
	add_child(dialog)
	$Letter3_Button.visible = false
	yield(dialog,'timeline_end')
	b_letter_finished += 1
	b_letter_finish()

#Letter4
func _on_Letter4_Button_mouse_entered():
	banim4.play("Letter4_Show")

func _on_Letter4_Button_mouse_exited():
	banim4.play("RESET")

func _on_Letter4_Button_pressed():
	var dialog = Dialogic.start("BLetter_4")
	add_child(dialog)
	$Letter4_Button.visible = false
	yield(dialog,'timeline_end')
	b_letter_finished += 1
	b_letter_finish()
	
#Letter5
func _on_Letter5_Button_mouse_entered():
	banim5.play("Letter5_Show")

func _on_Letter5_Button_mouse_exited():
	banim5.play("RESET")

func _on_Letter5_Button_pressed():
	var dialog = Dialogic.start("BLetter_5")
	add_child(dialog)
	$Letter5_Button.visible = false
	yield(dialog,'timeline_end')
	b_letter_finished += 1
	b_letter_finish()

