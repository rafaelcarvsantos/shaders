shader_type canvas_item;


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


float noise (float x){
	float i = floor(x);
	float f = fract(x);
	return clamp(mix(random (vec2(i,i)),random(vec2(i,i)+vec2(1.0)),smoothstep(0.0,1.0,f)),0.0,1.0);
}



void fragment() {
	float m = 0.0;
	float d = 0.0;
	
	float minDist = 10.0;
	
	if (false){
		for (float i=0.0;i<50.0;i++){
			vec2 st = vec2(random(vec2(i))/2.0);
			st.x= st.x+random(st);
			st.y = st.y*abs(sin(1.0*st.y))*5.0;
			st.x= st.x*abs(sin((1.0*st.x)))*1.0;
			
			d = length(UV-st);
			if (d<minDist){
				minDist = d;
			}
			m += smoothstep(0.05,0.049,d);
		}
	}
	else{	
		vec2 st = UV*6.0;
		//st.x=st.x+TIME;
		//vec2 gv = fract(st);
		vec2 id = floor(st);
		vec2 f_st = fract(st);
		
		for (float y=-1.0;y<=1.0;y++){
			for (float x=-1.0;x<=1.0;x++){
				vec2 point = vec2(random(id+vec2(x,y)));
				point = 0.5 + 0.5*sin(0.2 + 6.2831*point);
				vec2 diff = vec2(x,y) + point - f_st;
				minDist = min(minDist, length(diff));
				
			}
		}
	}
	//vec3 col = vec3(minDist);
	vec3 col = vec3(minDist)*1.2 *vec3(1.0,0.8,0.1);
	col = col + vec3(minDist*300.0)*1.5 *vec3(1.0,0.0,0.0);
	col = col + vec3(minDist)*1.5 *vec3(0.1,0.0,0.0);
	//col = col + mix(1.5,-0.0,minDist)*vec3(0.1,0.0,0.0)  ;
	COLOR = vec4(col,1);

}