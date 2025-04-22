use <samSCAD/samstdlib.scad>
use <bearing_riser/bearing_riser.scad>
use <base_plate/base_plate.scad>

module hollow_cube(v1, v2, v2_translate, center_bool) {
	x1 = v1[0];
	y1 = v1[1];
	z1 = v1[2];

	x2 = v2[0];
	y2 = v2[1];
	z2 = v2[2];

	v2tx = v2_translate[0];
	v2ty = v2_translate[1];
	v2tz = v2_translate[2];


	union() {
		difference() {
			translate([0, 0 ,0]) {
				cube([x1, y1, z1], center = center_bool);
			}
			translate([v2tx, v2ty, v2tz]) {
				cube([x2, y2, z2], center = center_bool);
			}
		}
	}
	
}

module neo_box_raw() {

	union() {
		translate([100, 100, 0]) 
			hollow_hex(outer_radius = 120 / 2, wall_thickness = 3, height = 159.5);
	}


	*union() {
		difference() {
			translate([0, 0, (159.5 / 2) + 5]) {
				hollow_cube(v1 = [105, 105, 159.5], v2 = [110, 100, 149.5], v2_translate = [0, 0, -5], center_bool = true);
			}
			translate([0, 0, 0]) {
				//color("red")
					cube([90, 100, 6], center = true);
			}
		}
		difference() {
			translate([0, 0, (159.5 / 2) + 5]) {
				hollow_cube(v1 = [105, 105, 159.5], v2 = [110, 100, 149.5], v2_translate = [0, 0, -5], center_bool = true);
			}
			translate([0, 0, 0]) {
				//color("red")
					cube([90, 100, 6], center = true);
			}
		}	
	}
}

module neo_mockup_diff() {
	union() {
		translate([0, 0, (58.3 / 2)]) {
			cylinder(h = 58.3, r1 = 57.9 / 2, r2 = 60 / 2, center = true);
		}
		translate([0, 0, (76.3 / 2) + 58.3]) {
			cube([61.9, 50.8, 76.3], center = true);
		}
	}	
}

module base_and_riser() {
	union() {
		base_plate();
		translate([0, 0, 5]) {
			bearing_riser();
		}
	}
}

module motor_and_box() {
	translate([60.96, 0, 134.5 + 5]) {
		rotate([0, 0, 90]) {
			import("../stl/neo_geared_80_1.stl");
		}
	}
}

module base() {
	difference() {
		base_and_riser();
		*motor_and_box();
		translate([60.96, 0,5 + (0.002)]) {
			rotate([0, 0, 90]) {
				*neo_mockup_diff();
			}
		}
	}
}

base();


// this gotta go
translate([100, 100, 0]) {
	*neo_mockup_diff();
	
hollow_hex(outer_radius=(120 - 5) / 2, wall_thickness = 50, height=10);
}

// this too
translate([0, 0, 0]) {
	neo_box_raw();
}
