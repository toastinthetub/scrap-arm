use <samSCAD/samstdlib.scad>

$fn = 100;

gearbox_height = 45;
neo_height = 45;
base_height = 3;


module base_helper() {
	union() {
		difference() {
			translate([0, 0, 3/2]) {
				cube([38, 38, 3], center = true);
			}
			translate([0, 0, -6]) {
				rotate([0, 0, 45]) {
					bolt_square(num_x = 2, num_y = 2, spacing_x = 30, spacing_y = 30 , hole_diameter = 2.2, hole_height = 12);
				}
			}
		}
		translate([0, 0, 3/2]) {
			cube([48, 15, 3], center = true);
		}
		translate([0, 0, 3/2]) {
			cube([15, 48, 3], center = true);
		}
	}
}

module base() {
	union() {
		difference() {
			base_helper();
			
			translate([0, 0, -0.01]) {
				rotate([0, 0 , 0]) {
					scale(1.007) nut_trap_circle(4, 42.1 / 2, "m2");
				}
			}
			translate([0, 0, -6]) {
				rotate([0, 0, 45]) {
					bolt_square(num_x = 2, num_y = 2, spacing_x = 30, spacing_y = 30 , hole_diameter = 2.2, hole_height = 12);
				}
			}
			translate([0, 0, 2 + (1/2) + 0.01]) {
				cylinder(h = 1.01, r = 18 / 2, center = true);			
			}
		}
	}
}

module pillars() {
	union() {
		translate([0, 0, 0]) {
			cube([0, 0, 0,], center = true);
		}
		translate([0, 0, 0]) {
			cube([0, 0, 0,], center = true);
		}
		translate([0, 0, 0]) {
			cube([0, 0, 0,], center = true);
		}
		translate([0, 0, 0]) {
			cube([0, 0, 0,], center = true);
		}

	}
}

module geared_550_test() {
	union() {
		base();
		pillars();
	}
}

geared_550_test() {
	
}
