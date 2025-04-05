use <../base_plate/base_plate.scad>;
use <../riser_base/riser_base.scad>;

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

$fn = 100;

// the actual bearing, bolts to bearing riser
module slewing_ring_bearing() {
	translate([0, 0, 122.45]) {
		rotate([0, 0, 30]) { // this had to be adjusted (360 / 6) / 2 degrees
			import("../RESOURCE_STL/slewing_ring.stl");
		}
	}
}

// TODO create screw holes, 6x m3 28mm bolt circle
module htd_sprocket() {
	translate([0, 0, (134.45)]) {
		union() {
			difference() {
				union() {
					import("../RESOURCE_STL/htd_sprocket.stl", center = true);
				}
				translate([0, 0, -5.6]) { 
					%bolt_circle(num_bolts = 6, circle_radius = (28 / 2), hole_diameter = 3, hole_height = 14.3);
				}
			}
		}
	}
}

module htd_pinion() {
	translate([0, -(69 / 2), 134.45]) {
		union() {
			import("../RESOURCE_STL/htd_pinion.stl", center = true);
		}
	}
}

module neo_60_to_1() {
	translate([0, - (69 / 2), 134.5]) {
		import("../RESOURCE_STL/neo_60_1.stl");
	}
}

// -------------------------------------- beyond this, code

// base plate
color("#818589") {
	translate([0, 0, - (5 / 1)]) base_plate();
}

// cylinder to cut out the middle of the riser body
module riser_body_diff_cylinder() {
	translate([0, 0, (122.45 / 2)]) {
		cylinder(h = 123, r1 = (44 /2), r2 = (44 / 2), center = true); 
	}
}

// aluminum riser body
module riser_body() {
	riser_body_lower();
	riser_body_higher();
}

// bearing riser assembly (TODO screw holes)
// 10x m4 on the bottom, 6x m3 on top
module bearing_riser() {
 	color("#E3E8EC") {
		union() {
			riser_body();
		}
	}
}


translate([0, (61.9 / 2), 0]) {
	bearing_riser();
}

// ------------------------------------------ BEYOND THIS, PERIPHIRALS

module mechanical_periphirals() {
	union() {
		translate([0, (61.9 / 2), 0]) {
			slewing_ring_bearing();
			htd_sprocket();
		}
		neo_60_to_1();
		htd_pinion();
		// TODO - create hex key model for neo + pinion
	}
}

mechanical_periphirals();
