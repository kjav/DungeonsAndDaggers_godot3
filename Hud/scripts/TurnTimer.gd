extends Node2D

const timePerTurn = 1
var timerNode
var degrees = 0
var colour = Color(255,255,0)

func _ready():
	GameData.player.connect("turnTimeChange", self, "timeChange")
	timerNode = self.get_node("Turn Timer")


func timeChange(timeElapsed):
	var proportion = timeElapsed / timePerTurn
	
	#slightly higher than 360 so that it looks like a small pause between turn end and start
	degrees = min(floor(proportion * 1.1 * 360), 360)
	#slight higher than 1-propotion (scaled from yellow to red) to allow period of yellow before it starts fading to redish
	colour = Color(1,1.3-proportion,0)
	
	update()

func _draw():
	draw_circle_arc_poly(Vector2(200, 200), 200, 0, degrees, colour)
	
	draw_circle(Vector2(200, 200), 170, Color(0.2,0.2,0.2))

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = []
    points_arc.push_back(center)
    var colors = [color]

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)