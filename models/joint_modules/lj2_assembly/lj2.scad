include <samSCAD/samstdlib.scad>
use <lib/neo_placeholder.scad>
include <hex-grid.scad>

$fn = 100;

// 608zz flanged bearing
module bearing_diff() {
	translate([0, 0, 7.9 / 2]) {
		cylinder(h = 9/*7.91*/, r = 28.575 / 2, center = true);
	}
	translate([0, 0, 1.1 / 2]) {
		cylinder(h = 1.11, r = 31.1 / 2, center = true);
	}
}

module hex_end(h) {
	translate([0, 0, 0]) {
		rotate([90, 90, 0])
		cylinder(h = h, r = 51 / 2, $fn = 6, center = true);
	}
}

module hex_of_radius_num(h, num) {
	translate([0, 0, h]);
	cylinder(h = h, r = num / sqrt(3),$fn = 6, center = true);
}


// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3.25, hole_height = 10);
	translate([0, 0, 10 / 2])
		cylinder(h = 10, r = (24 / 2) + 0.3, center = true);
	translate([0, 0, 0]) 
		bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 5.3, hole_height = 0.5);
}

module small_neo_pocket() {
	translate([0, 0, 0.5 / 2]) {
		cylinder(h = 0.5, r = 38 / 2, $fn = 6, center = true);
	}
}

module hex_half_hole(h) {
	translate([0, 0, h]);
	cylinder(h = h, r = 12.7 / sqrt(3),$fn = 6, center = true);
}

module neo() {
	translate([0, 0, 0]) rotate([0, 0, 0]) {
		neo_550();
	}
}

RAW_BRICK_HEIGHT = 51;

module raw_brick(h) {
	difference() {
		union() {
			translate([0, 0, 0]) rotate([0, 0, 0]) {
				*create_grid(size=[80,80,4],SW=10,wall=4);
				cube([45.75, 80, h], center = true);
			}
		}
		union() {
			
		}
	}
}

module attach_fulcrum() {
	difference() {
		union() {
			hex_end(45.75);
		}
		union() {
			translate([0, 6, 0]) rotate([0, 0, 0]) {
				scale(1.01)hex_end(12);
			}
			translate([0, 0, 0]) rotate([90, 90, 0]) {
				hex_half_hole(h = 50);
			}
		}
	}
}

module lj2() {
	difference() {
		union() {
			translate([0, 0, 0]) rotate([0, 0, 90]) {
				attach_fulcrum();
			}
			translate([0, 0, (25.5/2) + (RAW_BRICK_HEIGHT/2)]) rotate([0, 0, 0]) {
				raw_brick(RAW_BRICK_HEIGHT);
			}
		}
		union() {
			translate([0, 0 ,0]) rotate([0, 90, 0]) {
				%neo_550();
			}
		}
	}
}

lj2();
