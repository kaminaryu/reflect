extends StaticBody2D

@export var speed := 128
var corners_pos:Dictionary = {}
#@export var delay := 0.01

var direction := Vector2.RIGHT
var total_time := 0.0
var death_pos:Vector2

func _ready() -> void:
    print(corners_pos)

func _process(delta: float) -> void :
    position += direction * speed * delta
    
    #if (position in corners_pos) :
            #print("SHOULD TURN NOW (inacc)")
            #direction = direction.rotated( (PI/2) * -corners_pos[position])
            #corners_pos.erase(position)
    #
    #print("a", corners_pos)
    #print("b", position)
    #for corner in corners_pos :
        #if position.distance_to(corner) <= 1 :
            #print("SHOULD TURN NOW")
            
    for corner_pos in corners_pos.keys():
        if position.distance_to(corner_pos) <= 1.0:
            print("SHOULD TURN NOW (approx) at ", corner_pos)
            direction = direction.rotated(corners_pos[corner_pos])
            
            #corners_pos.erase(corner_pos)
            
            break  # exit loop after turning once
            
    if position.distance_to(death_pos) <= 1.0 :
        queue_free()
