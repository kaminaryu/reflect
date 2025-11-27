extends Node2D

#@onready var tween = create_tween()
@export var playing_anim := false

func _ready() -> void:
    get_parent().add_to_group("Objects")
    get_parent().modulate.a = 0.0
    
func toggle_visible() -> void :
    print("hello ", get_parent().visible, "  |  ", get_parent().modulate)
    get_parent().visible = true
    #$AnimationPlayer.play("FadeIn")
    #tween.tween_property(get_parent(), "modulate:a", 1.0, 1.0)
    showing()
    
    #$Timer.start()

 

#func _on_timer_timeout() -> void:
    #tween.tween_property(get_parent(), "modulate:a", 0.0, 1.0)
    
    
func showing() -> void :
    if playing_anim :
        return
        
    playing_anim = true
    
    var x := 0.0
    
    while x < 1.0 :
        x += 0.5 * (x + 0.1)
        get_parent().modulate.a = x
        await get_tree().create_timer(0.05).timeout
        #print("j")
        
    await get_tree().create_timer(1).timeout    
    
    while x > 0.0 :
        x -= 0.5 * (x + 0.1)
        get_parent().modulate.a = x
        await get_tree().create_timer(0.05).timeout
        #print("k")
    playing_anim = false
        
