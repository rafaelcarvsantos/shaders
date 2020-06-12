shader_type canvas_item;

uniform sampler2D mask_texture;

vec2 rotate2D (vec2 st, float angle) {
    st -= 0.5;
    st =  mat2(vec2(cos(angle),-sin(angle)),
                vec2(sin(angle),cos(angle))) * st;
    st += 0.5;
    return st;
}

float sawtooth(float valor){
	return  mod(valor,1.0);
}

float random (vec2 st) {
    return fract(sin(dot(st,
                         vec2(12.9898,78.233)))*
        43758.5453123);
}


void fragment() {
	vec2 st = UV*100.0;
	vec4 colour = texture(TEXTURE, UV);
	colour = vec4(vec3(colour.x,colour.y,colour.z) * mix(0.3,1.0,random(floor(st/2.0)*TIME)),1);

	COLOR = colour;

}