shader_type canvas_item;


vec3 criaCirculo(vec2 center, float radius, vec2 uv, float sino){
	
	vec3 col = vec3(smoothstep(distance(uv,center)-abs((sino*0.05)),distance(uv,center)+0.1,radius));
	return col;
	
}

float sawtooth(float valor){
	return  mod(valor,1.0);
}


void fragment() {
	vec2 st = UV * 64.0;

	st.x += step(1.0, mod(st.y,2.0)) * 0.5;
	st=fract(st);
	float offsetx = mix(-0.5,0.5,sawtooth(((TIME))*2.0));

	
	vec3 col = criaCirculo(vec2(1.0+offsetx,0.5),mix(0.3,-1.0,distance(UV,vec2(0.5,0.5))/3.0),st,1);
	col = col + criaCirculo(vec2(0.0+offsetx,0.5),mix(0.3,-1.0,distance(UV,vec2(0.5,0.5))/3.0),st,1);

	COLOR = vec4(col,1.0);

}