extends Node2D

const TOTAL_WAVES : int = 5
const WAVE_FRAME_GAPS : int = 10
const WAVE_SPEED : float = 6.7
const WAVE_RADIUS_LIMIT : float = 350.0
const WAVE_MAX_THICKNESS : float = 6.7
const RIPPLE_DAMPING : float = 0.5

var waveEmits := false
var waveCenter: Vector2
var waveFrame: Array[int]
var waveRadius: Array[float]
var waveThickness : Array[float]

func _input(evt) -> void :
    if evt is InputEventMouseButton :
        if evt.pressed and evt.button_index == MOUSE_BUTTON_LEFT :
            if waveEmits :
                return
            waveEmits = true
            waveCenter = get_global_mouse_position()
            #waveCenter = get_viewport().get_camera_2d().get_global_transform().affine_inverse().xform(evt.position)
            waveAnim()
            detect_enemies()
            
    
    
func waveAnim() -> void :
        
    waveFrame = []
    waveRadius = []
    waveThickness = []
    for i in range(TOTAL_WAVES) :
        waveRadius.append(-1)
        waveFrame.append(i * WAVE_FRAME_GAPS)
        waveThickness.append(WAVE_MAX_THICKNESS - i * RIPPLE_DAMPING)
    
    var frames := 0
    var wavesFinished := 0
    
    print("Emitting Waves at: ", waveCenter, " with radii of ", waveRadius, " and time frames of ", waveFrame)
    while waveEmits :
        for i in range(len(waveFrame)) :
            # skip the destroyed waves
            if waveFrame[i] == -1 :
                continue
                
            # if its the time to print the wave
            if frames > waveFrame[i] :
                waveRadius[i] += WAVE_SPEED
                #print("Wave[", i, "] Radius: ", waveRadius)
                
            # destroy waves
            if waveRadius[i] > WAVE_RADIUS_LIMIT :
                waveFrame[i] = -1
                #waveRadius[i] = -1
                wavesFinished += 1
        
        if wavesFinished >= TOTAL_WAVES :
            waveEmits = false
                            
        queue_redraw()
        frames += 1
        await get_tree().create_timer(0.01).timeout
        
    
func detect_enemies :
    pass   
    
    
func _draw() -> void :
    for i in range(len(waveFrame)) :
        # dont draw hidden or destroyed wave
        if waveFrame[i] == -1 :
            continue
            
        draw_circle(waveCenter, waveRadius[i], Color.GREEN_YELLOW, false, waveThickness[i])
        
    #draw_arc(waveCenter, waveRadius-10, 0, PI/2, 64, Color.RED, 10)
