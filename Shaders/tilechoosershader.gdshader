shader_type spatial;

uniform sampler2D tileset_texture;
uniform int tile_size;
uniform int tile_rows;
uniform int tile_cols;
uniform int tile_row=0;
uniform int tile_col=0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
    // Calculate the UV offset for the specific tile
    vec2 tile_uv = vec2(float(tile_col) / float(tile_cols), 1.0 - float(tile_row + 1) / float(tile_rows));
    vec2 tile_size_uv = vec2(float(tile_size) / float(tile_cols), float(tile_size) / float(tile_rows));

    // Calculate the UV coordinates for the current fragment inside the tile
    vec2 uv_in_tile = mod(SCREEN_UV - tile_uv, tile_size_uv) / tile_size_uv;

    // Sample the texture using the calculated UV coordinates
    vec4 color = texture(tileset_texture, uv_in_tile);

    // Output the sampled color
    COLOR = color.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
