use <samSCAD/samstdlib.scad>

$fn = 100;

// THIS WILL BE ANCHORED AT Z = 0 SO THAT IT CAN BE
// CONVENIENTLY TRANSLATED AROUND

module bearing_riser_upper() {
	union() {
		translate([0, 0, 5]) {
			hollow_cylinder(outer_d = 70, inner_d = 40, h = 117.5);
		}
	}
}

module bearing_riser_lower() {
	union() {
		difference() {
			translate([0, 0, 5/2]) {
				cylinder(h = 5, r = 50, center = true);
			}
		}
	}
}

module bearing_riser_diff_cylinder() {
	translate([0, 0, 0]) {
		cylinder(h = 150, r = 20, center = true);
	}
}

module bearing_riser_screw_holes_DIFF() {
	translate([0, 0, -1]) {
		bolt_circle(num_bolts = 10, circle_radius = 90 / 2, hole_diameter = 3.5, hole_height = 10);
	}
}

module bearing_riser_upper_screw_holes_DIFF() {
	union() {
		translate([0, 0, 122.5]) {
			bolt_circle(num_bolts = 6, circle_radius = 57 / 2, hole_diameter = 3.2 , hole_height = 5.01);
		}
	}
}

module bearing_riser() {
	difference() {
		union() {
			bearing_riser_lower();
			bearing_riser_upper();
		}
		bearing_riser_diff_cylinder();
		bearing_riser_screw_holes_DIFF();
		bearing_riser_upper_screw_holes_DIFF();
	}
}

bearing_riser();
