use <samSCAD/samstdlib.scad>
use <bearing_riser/bearing_riser.scad>
use <base_plate/base_plate.scad>

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
		motor_and_box();
	}
}

base();
