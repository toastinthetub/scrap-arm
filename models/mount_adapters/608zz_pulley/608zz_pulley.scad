use <MCAD/bearing.scad>
use <MCAD/gears.scad>
use <samSCAD/samstdlib.scad>

$fn = 100;

module gear_bearing_inner_nut_traps() {
	nut_trap_circle(2, 3);
}

module gear_bearing_inner() {
	difference() {
		translate([0, 0, 6]) {
			cylinder(h = 12, r = 6, center = true);
		}
		translate([0, 0, -0.1]) {
			bolt_circle(num_bolts = 2, circle_radius = 3, hole_diameter = 2.2, hole_height = 12.2);
		}
		translate([0, 0, 12 - 1.6]) {
			gear_bearing_inner_nut_traps();
		}
	}
}

module gear_bearing_outer() {
	union() {
		difference() {
			translate([0, 0, 6]) {
				cylinder(h = 12, r = 54 / 2, center = true);
			}
			translate([0, 0, 6 - 0.1]) {
				cylinder(h = 12.3, r = 31.6 / 2, center = true);
			}
			translate([0, 0, -0.2]) {
				bolt_circle(num_bolts = 4, circle_radius = 46 / 2, hole_diameter = 2.2, hole_height = 12.3);
			}
			translate([0, 0, -0.1]) {
				nut_trap_circle(4, 46 / 2, "m2");
			}
			translate([0, 0, 12.1 - 2]) { // this needs to go on the cap. i am tired.
				% bolt_circle(num_bolts = 4, circle_radius = 46 / 2, hole_diameter = 3, hole_height = 2.1);
			}
		}
	}
}

module gear_bearing() {
	import("gear_bearing.stl", center = true);
	gear_bearing_inner();
	gear_bearing_outer();
}

module bearing_housing_upper() {
	union() {
		difference() {
			cylinder(h = 4, r = 41.4 / 2, center = true);
		}
	}
}

module bearing_housing_lower() {
	union() {
		
	}
}

module gear_bearing_pulley() {
	union() {
		gear_bearing();
		*translate([0, 45, 2]) bearing_housing_upper();
		*translate([45, 0, 0]) bearing_housing_lower();
	}
}

gear_bearing_pulley();

module gear_bearing_pulley_printable() {
	union() {
		
	}
}

*gear_bearing_pulley_printable();
