include <samSCAD/samstdlib.scad>
include <lib/lj1_pulleys.scad>

module pulleys() {
	union() {
		translate([0, 15, 0]) sprocket();
		translate([0, -15, 0]) drive();
	}
}

module hex_shaft() {
	union() {
	}
}

module hex_spacers() {
	translate([0, -10, 0]) {
		hex_spacer(height=13, thickness=2, clearance=0.2);
	}
	translate([0, 10, 0]) {
		hex_spacer(height=13, thickness=2, clearance=0.2);
	}
	translate([0, 30, 0]) {
		hex_spacer(height=18, thickness=2, clearance=0.2);
	}
	translate([0, 50, 0]) {
		hex_spacer(height=18, thickness=2, clearance=0.2);
	}
}

module lj1_hardware() {
	union() {
		translate([30, 60, 0]) {
			pulleys();
		}
		translate([0, 30, 0]) {
			hex_spacers();
		}
	}
}

lj1_hardware();
