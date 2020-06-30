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

void fragment() {
	vec2 st = UV*16.0;
	
	
	st = rotate2D(st+smoothstep(0.8,1.5,noise(st/2.0)),noise(st/2.0)*0.1,UV) ;
	//st = rotate2D(st+noise(st),noise(st)*0.1,UV) ;
	st.x=st.x*0.8+TIME;

	vec3 col = vec3(mix(1.3,0.99,noise(st)));
	col = col * vec3(0.1,0.7,1.0);
	
	
	
	
	COLOR = vec4(col,0.8);

}

