shader_type canvas_item;

// How blurry is the screen? (0.0 = Clear, 5.0 = Super Blurry)
uniform float blur_amount : hint_range(0.0, 5.0) = 0.0;

// Used to read the screen behind this ColorRect
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	// 1. Get the screen coordinates
	vec2 uv = SCREEN_UV;
	
	// 2. Add a subtle "Wavy" effect (The Hypnosis part)
	// Only waves if the screen is blurry
	if (blur_amount > 0.0) {
		uv.x += sin(uv.y * 10.0 + TIME) * (blur_amount * 0.005);
		uv.y += cos(uv.x * 10.0 + TIME) * (blur_amount * 0.005);
	}
	
	// 3. Apply the Blur (Level of Detail)
	vec4 color = textureLod(SCREEN_TEXTURE, uv, blur_amount);
	
	COLOR = color;
}