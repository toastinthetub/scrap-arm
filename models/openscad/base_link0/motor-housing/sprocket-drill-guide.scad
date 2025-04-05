$fn = 100;

module bolt_circle(num_bolts, circle_radius, hole_diameter, hole_height) {
    for (i = [0:num_bolts-1]) {
        angle = i * 360 / num_bolts;
        x = circle_radius * cos(angle);
        y = circle_radius * sin(angle);
        translate([x, y, 0]) {
            cylinder(h = hole_height, d = hole_diameter);
        }
    }
}

module htd_pinion() {
	translate([0, 0, 0]) {
		difference() {
			cylinder(h = 14.29, r1 = 35 / 2, r2 = 35 / 2, center = true);
			cylinder(h = 15, r1 = 18 / 2, r2 = 18 / 2, center = true);
			bolt_circle(num_bolts = 6, circle_radius = (28 / 2), hole_diameter = 3, hole_height = 14.3);
		}
	}
}

htd_pinion();
