extends Node2D
# TODO: add a fucntion that duplicates the node and moves it across the screen

@export var speed = 250
var char_list = []
var counter = 0

@onready var box = $BoxOne 
@onready var box_text = $BoxOne/Label
@onready var box_two = $BoxTwo
@onready var box_two_text = $BoxTwo/Label
@onready var win_label = $WinLabel
@onready var start_position = $StartPosition


# Called when the node enters the scene tree for the first time.
func _ready():
	char_list = get_alphabet_list()
	print(char_list)
	Global.list_size = char_list.size()
	box.position = start_position.position
	display_text()
	send_box_two()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if char_list.size() != 0:
		box.position.x -= speed * delta
	else:
		box.visible = false
	if box_two.visible == true:
		box_two.position.x -= speed * delta
	#NOTE: I will propabably change this maybe???
	if !char_list:
		win_game()


func win_game():
	self.queue_free()
	

func send_box_two():
	await get_tree().create_timer(2.25).timeout
	box_two.position = start_position.position
	box_two_text.text = char_list.pop_front()
	box_two.visible = true

# NOTE: Might wanna move this to the global script
# This function will generate a list of all letters in the alphabet
func get_alphabet_list() -> Array:
	var alphabet_list = []
	for i in range(26):
		# Convert the index to a letter
		var letter = str(char(65 + i)) # 65 is the ASCII value for 'A'
		alphabet_list.append(letter)
	return alphabet_list # returns the list for whatever calls it


# NOTE: I dont like this function
func display_text():
	char_list.shuffle()
	box_text.text = char_list.pop_front()



func _on_reset_box_area_entered(area):
	if area == $BoxOne:
		box_text.text = char_list.pop_front()
		box.position = start_position.position
		counter += 1
	elif area == $BoxTwo:
		box_two_text.text = char_list.pop_front()
		box_two.position = start_position.position
		counter += 1
	if counter == 2:
		speed += 50
		counter = 0
