shader_type canvas_item;

vec2 random(vec2 st){
    st = vec2( dot(st,vec2(127.1,311.7)),
              dot(st,vec2(269.5,183.3)) );
    return -1.0 + 2.0*fract(sin(st)*43528.5432903);
}

float noise(vec2 st) {
    vec2 i = floor(st);
    vec2 f = fract(st);

    vec2 u = f*f*(3.0-2.0*f);

    return mix( mix( dot( random(i + vec2(0.0,0.0) ), f - vec2(0.0,0.0) ),
                     dot( random(i + vec2(1.0,0.0) ), f - vec2(1.0,0.0) ), u.x),
                mix( dot( random(i + vec2(0.0,1.0) ), f - vec2(0.0,1.0) ),
                     dot( random(i + vec2(1.0,1.0) ), f - vec2(1.0,1.0) ), u.x), u.y);
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

vec3 linha(float y, float angle, vec2 uv){
	vec2 st = rotate2D(uv,angle,vec2(0.5,0.5));
	float linha = step(y,st.y) + step(st.y+0.05,y);
	
	
	return vec3(mix(1.0,0.0,linha));
}

float lines(in vec2 pos, float b){
    float scale = 10.0;
    pos *= scale;
    return smoothstep(0.0,
                    .5+b*.5,
                    abs((sin(pos.x*3.1415)+b*2.0))*.5);
}

void fragment() {
	vec2 st = UV*16.0;
	
	//st = fract(st);
	
	
	//st = st+noise(st/5.0);
	st = st + rotate2D(st,noise(st/2.0),UV*noise(st));
	st = st + rotate2D(st,noise(st/4.0),UV);
	st = st + rotate2D(st,noise(st/8.0),UV);
	st = st + rotate2D(st,noise(st/16.0),UV);
	st = st + rotate2D(st,noise(st/32.0),UV);
	st.x=st.x+TIME;
	st.y=st.y+TIME/5.0;
	vec3 col = vec3(lines(st,0.5));
	st = rotate2D(st,0.5,UV);
	col = col * vec3(noise(st/4.0)*8.0,noise(st)*2.0,noise(st/2.0)*4.0);
	//st = rotate2D(st+noise(st),noise(st)*0.1,UV) ;
	//st.x=st.x*0.8+TIME;

	//col = vec3(mix(1.3,0.1,noise(st)));

	//col = col * vec3(0.8,smoothstep(0.1,1.0,noise(st)*2.0),0.1);
	
	COLOR = vec4(col,1.0);

}

