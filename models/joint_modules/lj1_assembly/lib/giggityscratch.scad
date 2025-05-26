include <samSCAD/samstdlib.scad>

// STUPID LIB STUFF

$fn = 100;

// 608zz flanged bearing
module bearing_diff() {
	translate([0, 0, (1.11) - 0.01])union() {
		translate([0, 0, 7.9 / 2]) {
			cylinder(h = 9/*7.91*/, r = 28.575 / 2, center = true);
		}
		translate([0, 0, -(1.11/2)]) {
			cylinder(h = 1.11, r = 31.1 / 2, center = true);
		}
	}
}

// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	// big holes
	translate([0, 0, 0]) union() {
		translate([0, 0, 0]) {
			bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3.32, hole_height = 20);
		}
		translate([0, 0, 20 / 2]) {
			cylinder(h = 20, r = (24 / 2) + 0.3, center = true);
		}
		// little holes
		translate([0, 0, 0]) {
			bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 6, hole_height = 1.5);
		}
	}
}

// 79
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
	difference() {
		translate([0, 0, 8 / 2]) {
			cube([191, 51, 8], center = true);
		}
		translate([191 / 2, 0, 0]) { // breaks if its 191. which should be correct. fuck.
			hex_end();
		}
		translate([-(191 / 2), 0, -0.1]) {
			*scale(1)hex_end();
		}
	}
	translate([191 / 2, 0, 0]) {
		hex_end();
	}
	translate([-(191 / 2), 0, 0]) {
		scale(1)hex_end();
	}
}

module plate_hex_ends() {
	difference() {
		plate_raw();
		translate([-(191 / 2), 0, 0]) {
			*hex_half_hole(h = 16.1);
		}
		translate([(191 / 2) /*fuckity*/ - (-14.2 + 79/2)/*unfuckity*/, 0, 8]) rotate([180, 0, 0]) {
			bearing_diff();
		}
	}
}

module small_neo_pocket() {
	translate([0, 0, 1 / 2]) {
		cylinder(h = 1.0, r = 38 / 2, $fn = 6, center = true);
	}
}

module three_hex_ends() {
	translate([0, 0, 0]) {
		hex_end();
	}
	translate([0, 0, 8]) {
		hex_end();
	}
	translate([0, 0, 16]) {
		hex_end();
	} 
}

// end lib

module fulcrum_attach_end() {
	difference() {
		union() {
			translate([-72/2, 0, 0]) rotate([0, 90, 0]) three_hex_ends();
			translate([-24/2, 0, 0]) rotate([0, 90, 0]) three_hex_ends();
			translate([24/2, 0, 0]) rotate([0, 90, 0]) three_hex_ends();
		}
		union() {
			translate([-19 + (10/2), 0, 0]) {
				cube([10, 60, 60], center = true);
			}
			translate([0, 0, 0]) rotate([0, 90, 0]) hex_half_hole(h = 100);
		}
	}
}

module holy_shit_this_is_fucked_up() {
	translate([-24 -0.01, -160/2 -(0.01), -51/2]) rotate([0, 0, 0]) ramp(width=24, height=160/2, depth=51);
	translate([-24, -160/2 - (0.01), 51/2]) rotate([0, 180, 0]) ramp(width=24, height=160/2, depth=51);
	translate([-24, -160/2 - (0.01) + (160/2), -51/2]) rotate([0, 0, 180]) ramp(width=24, height=160/2, depth=51);
}

module central_block_section() {
	difference() {
		union() {
			translate([0, 0, 0]) rotate([0, 0, 0]) {
				cube([72, 160, 45], center = true);
			}
		}
		union() {
			translate([-19 + (10/2), 160/2, 0]) {
				cube([10, 54, 60], center = true);
			}
			translate([0, 160/2, 0]) rotate([90, 0, 90]) hex_half_hole(h = 100);
			holy_shit_this_is_fucked_up();
		}
	}
}

module yoke_obstruction_diff() {
	cube([48, 34, 100], center = true);
}

module lj1_debug() {
	difference() {
		union() {

			// LJ2 ATTACH END
			translate([0, -160/2, 45/2]) {
				rotate([90, 0, 0]) {
					*fulcrum_attach_end();				
				}
			}
			// CENTRAL STRUCTURAL BLOCK
			translate([0, 0, 45/2]) {
				rotate([0, 0, 0]) {
					central_block_section();
				}
			}

			// FULCRUM ATTACH END
			translate([0, 160/2, 45/2]) {
				rotate([90, 0, 0]) {
					*fulcrum_attach_end();				
				}
			}
		}
		union() {
			translate([(-72/2 + 48/2) - 0.01, (160/2) - 48, 45]) yoke_obstruction_diff();
		}
	}
}

lj1_debug();
