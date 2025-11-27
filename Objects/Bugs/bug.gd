extends Area2D

@export var speed := 128
@export var health := 5

var corners_pos:Dictionary = {}
#@export var delay := 0.01

var direction := Vector2.RIGHT
var total_time := 0.0
var death_pos:Vector2


func _process(delta: float) -> void :
    position += direction * speed * delta
            
    for corner_pos in corners_pos.keys():
        if position.distance_to(corner_pos) <= 1.0:
            #print("SHOULD TURN NOW (approx) at ", corner_pos)
            direction = direction.rotated(corners_pos[corner_pos])
            
            #corners_pos.erase(corner_pos)
            
            break  # exit loop after turning once
            
    if position.distance_to(death_pos) <= 1.0 :
        queue_free()


func _on_body_entered(body: Node2D) -> void:
    print("die")
    body.queue_free()
    
    health -= 1
    
    if health < 1 :
        queue_free()
        remove_from_group("Bugs")
