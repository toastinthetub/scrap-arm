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

module plate() {
	translate([0, 0, (5 / 2)]) {
		cube([200, 200, 5], center = true);
	}
}

module screw_holes() {
	union() {
		translate([80, 80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([80, -80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([-80, 80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([-80, -80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
	}
}

module neo_mockup() {
	cylinder(h = 58.3, r1 = 57 / 2, r2 = 60 / 2, center = true);
}

module base_plate() {
	union() {
		difference() {
			plate();

			screw_holes();
			translate([0, 65 / 2, -0.1]) {
				bolt_circle(num_bolts = 10, circle_radius = (90 / 2), hole_diameter = 3.3, hole_height = 13.1);
			}
			/*
			translate([0, -(65 / 2), (58.3 / 2)]) {
				neo_mockup();
			} */
		}
	}
}

base_plate();
