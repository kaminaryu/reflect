extends Area2D

@export var speed := 128
@export var score := 10
@export var min_money := 3
@export var max_money := 6

var health:int

var corners_pos:Dictionary = {}
#@export var delay := 0.01

var direction := Vector2.RIGHT
var total_time := 0.0
var death_pos:Vector2


func _process(delta: float) -> void :
    if not Brain.game_running :
        return
        
    position += direction * speed * delta
            
    for corner_pos in corners_pos.keys():
        if position.distance_to(corner_pos) <= 1.0:
            #print("SHOULD TURN NOW (approx) at ", corner_pos)
            direction = direction.rotated(corners_pos[corner_pos])
            
            #corners_pos.erase(corner_pos)
            
            break  # exit loop after turning once
            
    if position.distance_to(death_pos) <= 1.0 :
        queue_free()
        GlobalStats.decrease_health()



#func toggle_visible(state:String) -> void :
    #if state == "visible" :
        #visible = true
        #$AnimationPlayer.play("FadeIn")
        #
        #$Timer.start()
    #
#func _on_timer_timeout() -> void:
    #$AnimationPlayer.play("FadeOut")
    
    
func _on_body_entered(body: Node2D) -> void:
    if body.name != "Bullet" :
        #return
        pass
        
    if body.piercing_left > 0 :
        body.piercing_left -= 1
    else :
        body.queue_free()
    
    health -= body.damage
    
    if health < 1 :
        $AudioStreamPlayer2D.play()
        print("isdj")
        GlobalStats.player_score += score
        GlobalStats.player_money += randi_range(min_money, max_money)
        remove_from_group("Bugs")
        visible = false


func _on_audio_stream_player_2d_finished() -> void:
    queue_free()
