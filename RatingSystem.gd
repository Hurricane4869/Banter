extends Node2D

@onready var rating_dummy = $RatingDummy
@onready var quest_timer = get_node("$../QuestTimer/Timer")

@onready var perfect_time = 60
@onready var half_time = 30
@onready var bad_time = 5

@onready var perfect_rating = 3
@onready var half_rating = 2
@onready var bad_rating = 1

const base_text = "Kamu mendapat rating: 3"
var rating

func _process(delta):
	rating_dummy.text = base_text #+ str(rating)
	
func _process_rating(time_left):
	var rating = 0
	if time_left >= perfect_time:
		rating = perfect_rating
	elif perfect_time > time_left and time_left >= half_time:
		rating = half_rating
	elif half_time > time_left and time_left >= bad_time:
		rating = bad_rating
	return rating	

	
		



