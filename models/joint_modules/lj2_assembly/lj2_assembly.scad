use <samSCAD/samstdlib.scad>

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

module small_neo_pocket() {
	translate([0, 0, 0.5 / 2]) {
		cylinder(h = 0.5, r = 38 / 2, $fn = 6, center = true);
	}
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

module brick_raw() {
	translate([0, 0, 8 / 2]) {
		cube([192, 51, 8], center = true);
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
		translate([192 / 2, 0, 0]) {
			hex_half_hole(h = 16.1);
		}
		translate([-(192 / 2), 0, 0]) {
			bearing_diff();
		}
	}
}

module neo_plate() {
	difference() {
		union() {
			plate_hex_ends();
		}
		translate([31, 0, -0.1]) {
			neo_550_bolt_circle();
			translate([0, 0, 7.9]) small_neo_pocket();
		}
	}
}

// wall thickness = 8mm
// throw a 550 in there with 3mm clearance on the inside to fit
// which means IW of this link is 38 - 6 = 32, with a diff in it

module neo_lj2_diff() {
	translate([0, 0, 0]) rotate([0, 0, 0]) {
		cylinder(h = h, r = 38 / sqrt(3),$fn = 6, center = true);
	}
}

// circle 36.8 + cable part 7.34mm
module neo_lj2_housing() {
	hollow_cylinder(outer_d = 37.9, inner_d = 36.9);
}

module lj2_frame_bottom() {
	// bottom
	difference() {
		union() {
			translate([0, 0, 0]) {
				rotate([0, 0, 0]) {
					brick_raw();
				}
			}
		}

		// bool
		
		
	}
}

module lj2_frame_outside() {
	translate([0, 16 + (32 / 2), 51 / 2]) {
		rotate([90, 0, 0]) {
			plate_hex_ends();
		}
	}
	translate([0, - 8 - (32 / 2), 51 / 2]) {
		rotate([90, 0, 0]) {
			plate_hex_ends();
		}
	}
}

module lj2() {
	lj2_frame_outside();
	lj2_frame_bottom();
	translate([50, 0, 0]) {
		neo_lj2_housing();
	}
}

lj2();
