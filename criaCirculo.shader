shader_type canvas_item;

vec3 criaCirculo(vec2 center, float radius, vec2 uv, float sino){
	
	vec3 col = vec3(smoothstep(distance(uv,center)-abs((sino*0.05)),distance(uv,center)+0.02,radius));
	return col;
	
}


void fragment() {
	vec3 col = criaCirculo(vec2(0.5,0.5),0.1,UV,sin(TIME));
	col = col + criaCirculo(vec2(0.2,0.2),0.1,UV,sin(TIME));
	
	COLOR = vec4(col,1.0);

}