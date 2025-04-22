use <samSCAD/samstdlib.scad>

$fn = 100;

// THIS WILL BE ANCHORED AT Z = 0 SO THAT IT CAN BE
// CONVENIENTLY TRANSLATED AROUND

module bearing_riser_upper() {
	union() {
		translate([0, 0, 5]) {
			hollow_cylinder(outer_d = 70, inner_d = 40, h = 117.5);
		}
	}
}

