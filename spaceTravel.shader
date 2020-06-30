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

float circle(in vec2 _st, in float _radius){
    vec2 dist = _st-vec2(0.5);
	return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(dist,dist)*4.0);
}


void fragment() {
	vec2 st = UV;
	st = st -vec2(0.5);
	
	st =  vec2(abs(atan(st.x,st.y)),length(st));
	st = st *8.0;
	st = rotate2D(st,TIME*20.0,vec2(0.5));
	st= fract(st);
	
	
	

	//st = fract(st);
	vec3 col = vec3(smoothstep(0.4,0.5,st.x) - smoothstep(0.5,0.6,st.x))*vec3(smoothstep(0.3,0.5,st.y) - smoothstep(0.5,0.6,st.y));
	//vec3 col = vec3(st.x);
	
	COLOR = vec4(col,1.0);

}

