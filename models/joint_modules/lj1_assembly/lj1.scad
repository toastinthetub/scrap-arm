include <samSCAD/samstdlib.scad>

// STUPID LIB STUFF

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

// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3.25, hole_height = 10);
	translate([0, 0, 10 / 2])
		cylinder(h = 10, r = (24 / 2) + 0.3, center = true);
	translate([0, 0, 0]) 
		bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 5.3, hole_height = 0.5);
}

module hex_half_hole(h) {
	translate([0, 0, h]);
	cylinder(h = h, r = 12.7 / sqrt(3),$fn = 6, center = true);
}

module hex_end() {
	translate([0, 0, 8 / 2]) {
		rotate([0, 0, 90])
		cylinder(h = 8, r = 51 / 2, $fn = 6, center = true);
	}
}

module plate_raw() {
	translate([0, 0, 8 / 2]) {
		cube([192, 51, 8], center = true);
	}
	translate([192 / 2, 0, 0]) {
		hex_end();
	}
	translate([-(192 / 2), 0, 0]) {
		hex_end();
	}
}

module plate_hex_ends() {
	difference() {
		plate_raw();
		translate([-(192 / 2), 0, 0]) {
			hex_half_hole(h = 16.1);
		}
		translate([(192 / 2), 0, 7.9]) rotate([180, 0, 0]) {
			bearing_diff();
		}
	}
}

module small_neo_pocket() {
	translate([0, 0, 0.5 / 2]) {
		cylinder(h = 0.5, r = 38 / 2, $fn = 6, center = true);
	}
}


// END STUPID LIB STUFF ======================================================

// this is gonna be the plate that goes on top of the other plate.
module neo_rawish_helper() {
	// TODO
}

module neo_side_rawish() {
	translate([0, 0, 8]) rotate([180, 0, 0]) plate_hex_ends();
	translate([0, 0, 8]) rotate([0, 0, 0]) plate_hex_ends();	
}

module neo_side_helper() {
	// the now has a 1/2 inch hex hole and a spot for a press fit bearing
	difference() {
		/*plate_hex_ends();
		translate([-14.2, 0, 7.501])small_neo_pocket(); */

			neo_side_rawish();
	}
}

module neo_side() {
	difference() {
		// MODEL TO SUBTRACT FROM
		union() {
			neo_side_helper();
		}
		// SUBTRACTION
		union() {
			// model();
		}
	}
}

module bearing_side_helper() {
	difference() {
		plate_hex_ends();
	}
}

module bearing_side() {
	difference() {
		union() {
			bearing_side_helper();
		}
		union() {
			
		}
	}
}

module debug() {
	translate([0, 50, 0]) rotate([0, 0, 0]) {
		neo_side();
	}
	translate([0, -50, 0]) rotate([0, 0, 0]) {
		bearing_side();
	}
}

// FULL ASSEMBLY
module assembly() {
	translate([0, -(16.75 / 2), 51 / 2]) rotate([90, 0, 0]) {
		neo_side();
	}
	translate([0, (16.75 / 2), 51 / 2]) rotate([270, 0, 0]) {
		bearing_side();
	}
}

*assembly();
debug();
