shader_type canvas_item;

vec2 rotate2D (vec2 st, float angle) {
    st -= 0.5;
    st =  mat2(vec2(cos(angle),-sin(angle)),
                vec2(sin(angle),cos(angle))) * st;
    st += 0.5;
    return st;
}

vec3 criaTriangulo(vec2 uv){
	return vec3(step(1.0,uv.x+uv.y));
}

float sawtooth(float valor){
	return  mod(valor,1.0);
}


void fragment() {
	vec3 cor = vec3(0.0);
	vec2 st = UV *32.0;

//st.x += step(1.0, mod(st.y,2.0)) * 0.5;
	//st =rotate2D(st, 0.5*3.14*step(1.0,mod(st.y,2.0)));

	if (step(1.0,mod(st.y,2.0)) == 1.0){
		st.y=-st.y;
	}
	if (step(1.0,mod(st.x,2.0)) == 1.0){
		st.x=-st.x;
	}
	
	
	st=fract(st);
	//st=rotate2D(st,TIME);

	vec3 col = criaTriangulo(st);
	
	COLOR = vec4(col,1.0);

}