extends Control
#this has working display subviewport

var target_word = "crowbar"
var guessed_letters = []

var word_label
var input_line
var submit_button
var message_label

func _ready(): 
	word_label = $WordLabel
	input_line = $GuessInput
	submit_button = $SubmitButton
	message_label = $MessageLabel

	
	submit_button.pressed.connect(_on_submit_guess)
	update_display()

func update_display():
	var display = ""
	for c in target_word:
		display += c + " " if c in guessed_letters else "_ "
	word_label.text = display.strip_edges()

	# Check for win
	var all_guessed = true
	for c in target_word:
		if c not in guessed_letters:
			all_guessed = false
			break
	if all_guessed:
		message_label.text = "You guessed the word! It was: " + target_word
		submit_button.disabled = true
		input_line.editable = false

func _on_submit_guess():
	var guess = input_line.text.to_lower().strip_edges()
	input_line.text = ""

	if guess.length() != 1 or not guess.is_valid_identifier():
		message_label.text = "Please enter a single letter."
		return

	if guess in guessed_letters:
		message_label.text = "You already guessed that letter."
		return

	guessed_letters.append(guess)
	update_display()
	message_label.text = ""  # clear message on correct input
