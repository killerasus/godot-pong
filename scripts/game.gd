extends Node2D

@onready var ball_scene = preload("res://scenes/ball.tscn")
@onready var player1_score : int = 0
@onready var player2_score : int = 0
@onready var hud = $UI/HUD
@onready var paddle_half_height = 0.5*$PaddleP1/Sprite2D.get_rect().size.x*$PaddleP1/Sprite2D.scale.x # Rotated
@onready var paddle_half_width = 0.5*$PaddleP1/Sprite2D.get_rect().size.y*$PaddleP1/Sprite2D.scale.y # Rotated
@onready var ball_half_size = 0.5*$Ball/Sprite2D.get_rect().size.y*$Ball/Sprite2D.scale.y

func _physics_process(delta):
	if Input.is_action_pressed("p1_moveup"):
		$PaddleP1.global_position.y -= $PaddleP1.speed*delta
	elif Input.is_action_pressed("p1_movedown"):
		$PaddleP1.global_position.y += $PaddleP1.speed*delta
	
	$PaddleP1.global_position.y = clamp($PaddleP1.global_position.y, $Limits.global_position.y + paddle_half_height,
		$Limits.global_position.y + $Limits.get_rect().size.y - paddle_half_height)
	
	$Ball.global_position += $Ball.speed*delta
	
	if ($Ball.global_position.x - ball_half_size) < 0:
		$Ball.speed.x *= -1
		player2_score += 1
		hud.set_p2_score_label(player2_score)
		
	if ($Ball.global_position.x + ball_half_size) > $Limits.get_rect().size.x:
		$Ball.speed.x *= -1
		player1_score += 1
		hud.set_p1_score_label(player1_score)
	
	if ($Ball.global_position.y - ball_half_size) < $Limits.global_position.y or ($Ball.global_position.y + ball_half_size) > ($Limits.global_position.y + $Limits.get_rect().size.y):
		$Ball.speed.y *= -1
	
	$Ball.global_position = $Ball.global_position.clamp(Vector2(ball_half_size, $Limits.global_position.y + ball_half_size),
		Vector2($Limits.get_rect().size.x - ball_half_size, $Limits.global_position.y + $Limits.get_rect().size.y - ball_half_size))	

# Ball hits paddle p1
func _on_paddle_p_1_area_entered(area):
	area.speed.x *= -1
	area.global_position.x = $PaddleP1.global_position.x + paddle_half_width + ball_half_size
