shader_type canvas_item;


vec3 criaQuadrado(vec2 center, float radius, vec2 uv){
	
	float l = step(uv.x-radius,center.x);
	float r=  step(center.x,uv.x+radius);
	float t = step(uv.y-radius,center.y);
	float b=  step(center.y,uv.y+radius);
	
	vec3 col = vec3(l*r*t*b);
	return col;
	
}

float random (vec2 st) {
    return fract(sin(dot(st,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}


vec2 rotate2D (vec2 st, float angle, vec2 center) {
    st.x -= center.x;
	st.y -= center.y;
    st =  mat2(vec2(cos(angle),-sin(angle)),
                vec2(sin(angle),cos(angle))) * st;
    st.x += center.x;
	st.y += center.y;
    return st;
}

vec2 scale (vec2 st, float size, vec2 center){
	st.x -= center.x;
	st.y -= center.y;
    st = st/size;
    st.x += center.x;
	st.y += center.y;
    return st;
	
}

float noise (float x){
	float i = floor(x);
	float f = fract(x);
	return clamp(mix(random (vec2(i,i)),random(vec2(i,i)+vec2(1.0)),smoothstep(0.0,1.0,f)),0.0,1.0);
}



void fragment() {
	vec2 st = rotate2D(UV,3.15*noise(TIME),vec2(0.5,0.5));
	vec2 st1 = rotate2D(st,3.14*noise(TIME),vec2(0.5,0.5));
	
	vec3 col = criaQuadrado(vec2(0.5,0.5),0.1,st1);
	
	vec2 st2 = rotate2D(st,noise(TIME/0.2),vec2(0.3,0.3));
	st2 = scale(st2,noise(TIME)*1.5,vec2(0.3,0.3));
	col = col + criaQuadrado(vec2(0.3,0.3),0.1,st2);

	//col = col * vec3(noise(st.y*TIME*5.0));
	COLOR = vec4(col,1.0);

}