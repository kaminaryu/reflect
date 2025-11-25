extends Area2D

@export var direction:Vector2
@export var speed:float
@export var maxLife:float

var totalTime := 0.0
func _process(delta) -> void :
    position += direction * delta * speed
    #print("bullet position: ", global_position)
    
    totalTime += delta
    if totalTime > maxLife :
        queue_free()
