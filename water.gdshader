shader_type canvas_item;

//godot 4.2
uniform sampler2D SCREEN_TEXTURE: hint_screen_texture, filter_nearest;

uniform vec2 scale;
uniform float y_zoom;
uniform vec4 water_color: source_color = vec4(0.0, 0.129, 0.522, 0.5);
uniform sampler2D noise;
uniform vec2 distortion_scale;
uniform float intensity;
uniform float speed;

uniform float wave_amplitude;
uniform float wave_speed;
uniform float wave_period: hint_range(0.1, 4.0);

void fragment() {
	float uv_height = SCREEN_PIXEL_SIZE.y / TEXTURE_PIXEL_SIZE.y;

	float distortion = texture(noise, UV * scale * distortion_scale * TIME * speed).x;
	distortion -= 0.5;

	vec2 reflected_screen_uv = vec2(SCREEN_UV.x - distortion * intensity * y_zoom, SCREEN_UV.y + uv_height * UV.y * 2.0 * scale.y * y_zoom);
	vec4 reflection = texture(SCREEN_TEXTURE, reflected_screen_uv);

	float wave_randomness = cos(0.2 * UV.x * scale.x / wave_period + TIME * wave_speed);
	float waves = UV.y * scale.y + sin(UV.x * scale.x / wave_period - TIME * wave_speed) * wave_randomness * wave_amplitude - wave_amplitude;

	//test wave
	//COLOR.rgb = vec3(smoothstep(0.1, 0.13, waves));
	COLOR.rgb = mix(reflection.rgb, water_color.rgb, water_color.a);

	COLOR.a = smoothstep(0.1, 0.13, waves);
}
