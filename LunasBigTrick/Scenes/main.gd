extends Node


@onready var letter = $LetterDisplay/BoxOne/Label
@onready var letter_two = $LetterDisplay/BoxTwo/Label
@onready var text_box = $LetterDisplay
@onready var win = $YouDidItLabel

@onready var letter_display_node = get_node("LetterDisplay")

var box_one_entered = false
var box_two_entered = false

var is_pressed = false
var list = null


# Called when the node enters the scene tree for the first time.
func _ready():
	list = letter_display_node.char_list
	win.text = str("Letters Correct: ", Global.correct_count, " / ", str(Global.list_size))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Called when an input event is detected.
func _input(event):
	if event is InputEventKey:
		var key_name = OS.get_keycode_string(event.key_label)

		if box_one_entered == true:
			if key_name == letter.text:
				if is_pressed == false:
					Global.correct_count += 1
					is_pressed = true
			print("Key pressed: ", key_name)
			print(" The letter is: ", letter.text)
			if key_name != letter.text:
				is_pressed = true

		elif box_two_entered == true:
			if key_name == letter_two.text:
				if is_pressed == false:
					Global.correct_count += 1
					is_pressed = true
			print("Key pressed: ", key_name)
			print(" The letter is: ", letter_two.text)
			if key_name != letter_two.text:
				is_pressed = true

		win.text = str("Letters Correct: ", Global.correct_count, " / ", str(Global.list_size))


func _on_box_thingy_area_entered(area):
	if area == $LetterDisplay/BoxOne:
		box_one_entered = true
	elif area == $LetterDisplay/BoxTwo:
		box_two_entered = true



func _on_box_thingy_area_exited(area):
	if area == $LetterDisplay/BoxOne:
		box_one_entered = false
	elif area == $LetterDisplay/BoxTwo:
		box_two_entered = false
	is_pressed = false
	


func _on_letter_display_child_exiting_tree(node):
	var score =   float(Global.correct_count / Global.list_size)
	win.text = str("Your score: ", Global.correct_count, " / ", Global.list_size)

# TODO: Make this work better
func _on_audio_stream_player_finished():
	$AudioStreamPlayer.pitch_scale += 0.05
	$AudioStreamPlayer.play()
