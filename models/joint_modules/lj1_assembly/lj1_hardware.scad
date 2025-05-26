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

module lj1_hardware() {
	union() {
		translate([30, 60, 0]) {
			pulleys();
		}
		translate([0, 0, 0]) {
		}
	}
}

lj1_hardware();
