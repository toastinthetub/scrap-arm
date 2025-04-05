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

// cylinder to cut out the middle of the riser body
module riser_body_diff_cylinder() {
	translate([0, 0, (122.45 / 2)]) {
		cylinder(h = 123, r1 = (44 /2), r2 = (44 / 2), center = true); 
	}
}

// upper plate
module riser_body_lower() {
	color("#636363") {
		union() {
			difference() {
				translate([0, 0, (12 / 2)]) {
					cylinder(h = 12, r1 = 50, r2 = 50, center = true);
				}
				translate([0, 0, -0.1]) {
					bolt_circle(num_bolts = 10, circle_radius = (90 / 2), hole_diameter = 3.3, hole_height = 13.1);
				}
				translate([0, 0, -0.1]) {
					bolt_circle(num_bolts = 6, circle_radius = (57 / 2), hole_diameter = 3.3, hole_height = 13.1);
				}
				translate([0, 0, -0.1]) {
					bolt_circle(num_bolts = 6, circle_radius = (57 / 2), hole_diameter = 5.7, hole_height = 1.65);
				}
				riser_body_diff_cylinder();
			}
		}
	}
}

// upper plate
module riser_body_higher() {
	color("#777777") {
		union() {
			difference() {
				translate([0, 0, (122.45 / 2)]) {
					cylinder(h = 122.45, r1 = 35, r2 = 35, center = true);
				}
				translate([0, 0, (122.45) - 5]) {
					bolt_circle(num_bolts = 6, circle_radius = (57 / 2), hole_diameter = 2.5, hole_height = 5.1);
				}
				translate([0, 0, -0.1]) {
					bolt_circle(num_bolts = 6, circle_radius = (57 / 2), hole_diameter = 3.3, hole_height = 8.01);
				}

				riser_body_diff_cylinder();
			}
		}
	}
}

union() {
	riser_body_lower();

	translate([0, 0, 12]) {
		*riser_body_higher();
	}
}
