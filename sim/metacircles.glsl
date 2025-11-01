// extern number colour_count = 5;
// extern vec3[] colours;
extern Image sampler;

vec4 effect(vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords) {
	float brightness = Texel(texture, texture_coords).r; // This is the current pixel color

	vec4 pcol = Texel(sampler, vec2(brightness, 0)); // This is the current pixel color

	// vec4 outc;
	// outc.r = pcol.r;
	// vec4 outc = vec4(1, 1, 1, brightness);
	// return outc;
	// return Texel(texture, texture_coords);
	return pcol;
}
