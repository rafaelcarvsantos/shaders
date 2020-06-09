shader_type canvas_item;


vec3 criaQuadrado(vec2 center, float radius, vec2 uv){
	
	float l = step(uv.x-radius,center.x);
	float r=  step(center.x,uv.x+radius);
	float t = step(uv.y-radius,center.y);
	float b=  step(center.y,uv.y+radius);
	
	vec3 col = vec3(l*r*t*b);
	return col;
	
}

mat2 rotate2d(vec2 uv,float t){
	return mat2(vec2(cos(t),-sin(t)),vec2(sin(t),cos(t)));
}


void fragment() {
	vec2 st = (UV-vec2(0.2))*2.0-vec2(0.5,0.5);
	st = rotate2d(st,sin(TIME*1.5)*9.0) * st;
	st = st+vec2(0.5,0.5);

	st.y=st.y+0.4*sin(TIME);
	
	vec3 col = criaQuadrado(vec2(0.5,0.5),0.05,st);
	st = st - vec2(0.1,0.1);
	st = rotate2d(st,sin(TIME))*st;

	
	col = col + criaQuadrado(vec2(0.1,0.1),0.05,st);
	col = col + criaQuadrado(vec2(0.6,0.6),0.05,st);
	col = col + criaQuadrado(vec2(0.3,0.3),0.05,st);
	col = col + criaQuadrado(vec2(0.5,0.1),0.05,st);
	//col = col+ criaQuadrado(vec2(0.1,0.3),0.1,st);
	
	COLOR = vec4(col,1.0);

}