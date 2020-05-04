extends Node2D

var degrees = 0
var colour = Color(255,255,0)

func _draw():
	draw_circle_arc_poly(Vector2(200, 200), 200, 0, degrees, colour)
	
	draw_circle(Vector2(200, 200), 170, Color(0.8,0.8,0.8))

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = []
    points_arc.push_back(center)
    var colors = [color]

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)