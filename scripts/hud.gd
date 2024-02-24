extends Control

@onready var p1_score_label = $P1Score
@onready var p2_score_label = $P2Score

func set_p1_score_label(new_score):
	p1_score_label.text = str(new_score)

func set_p2_score_label(new_score):
	p2_score_label.text = str(new_score)
