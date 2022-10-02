shader_type spatial;
uniform float strength = 0.5;

render_mode unshaded, cull_front;

uniform bool enable = false;
uniform float outline_thickness = 0.01;
uniform vec4 color = vec4(0.88, 1.0, 0.0, 0.5);

void vertex() {
	if (enable) {
        VERTEX += normalize(VERTEX) * outline_thickness;
        // Make the outline not clip into the ground...
        VERTEX.y += outline_thickness;
	}
}

void fragment() {
    if (enable) {
        ALBEDO = color.rgb;
        ALPHA = strength;
	} else {
        ALPHA = 0.0;
    }
}