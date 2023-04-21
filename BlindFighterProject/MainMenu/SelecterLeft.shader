shader_type canvas_item;

uniform float height = 2.5;
uniform float speed = 4.0;

void vertex(){
	VERTEX.x -= height * sin(speed * TIME);
}