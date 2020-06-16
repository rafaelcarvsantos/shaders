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

float noise (vec2 pos){
	vec2 i = floor(pos);
    vec2 f = fract(pos);

    // Four corners in 2D of a tile
    float a = random(i);
    float b = random(i + vec2(1.0, 0.0));
    float c = random(i + vec2(0.0, 1.0));
    float d = random(i + vec2(1.0, 1.0));

    // Smooth Interpolation

    // Cubic Hermine Curve.  Same as SmoothStep()
    vec2 u = f*f*(3.0-2.0*f);
    // u = smoothstep(0.,1.,f);

    // Mix 4 coorners percentages
    return mix(a, b, u.x) +
            (c - a)* u.y * (1.0 - u.x) +
            (d - b) * u.x * u.y;
}



void fragment() {
	vec2 st = UV * 64.0;
	st = rotate2D(st, TIME/4.0, vec2(0.5,0.5));
	vec2 st2 = rotate2D(UV*32.0, TIME/4.0, vec2(0.3,0.3));
	
	vec3 col = vec3(noise(st*mix(0.0,5.0,distance(UV,vec2(0.5,0.5)))));

	//col = col * vec3(noise(st.y*TIME*5.0));
	COLOR = vec4(col,1.0);

}