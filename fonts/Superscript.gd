extends RichTextEffect
class_name RichTextSuperscript

# Syntax: [superscript][/superscript]

# Define the tag name.
var bbcode := "superscript"


func _process_custom_fx(char_fx: CharFXTransform):

	char_fx.offset.y -= 6  # Raise the text up; adjust this value as needed
	
	return true  # Continue processing the effect
