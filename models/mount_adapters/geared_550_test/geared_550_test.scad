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
					%bolt_square(num_x = 2, num_y = 2, spacing_x = 30, spacing_y = 30 , hole_diameter = 2.2, hole_height = 12);
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
		base_helper();
	}
}
module geared_550_test() {
	union() {
		base();
	}
}

geared_550_test() {
	
}
