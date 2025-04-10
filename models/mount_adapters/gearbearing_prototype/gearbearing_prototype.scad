use <MCAD/bearing.scad>
use <MCAD/gears.scad>
use <samSCAD/samstdlib.scad>

$fn = 150;

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
		}
	}
}

module gear_bearing() {
	import("gear_bearing.stl", center = true);
	gear_bearing_inner();
	gear_bearing_outer();
}

module bearing_housing_upper_bracket() {
	union() {
		difference() {
			cylinder(h = 4, r = 54 / 2, center = true);
			
			translate([0, 0, -0.1]) {
				cylinder(h = 5, r = 40 / 2, center = true);
			}
			translate([0, 0, 0.91]) { // this needs to go on the cap. i am tired.
				bolt_circle(num_bolts = 4, circle_radius = 46 / 2, hole_diameter = 3, hole_height = 1.1);
			}
			translate([0, 0, -5]) {
				bolt_circle(num_bolts = 4, circle_radius = 46 / 2, hole_diameter = 2.2, hole_height = 12.3);
			}
		}
	}
}

module bearing_housing_upper_output_screw_holes() {
	union() {
		translate([0, 0, -1.1]) { // this needs to go on the cap. i am tired.
			bolt_circle(num_bolts = 10, circle_radius = 30 / 2, hole_diameter = 3, hole_height = 1.1);
		}
		translate([0, 0, -1.1]) {
			nut_trap_circle(10, 15, "m2");
			bolt_circle(num_bolts = 10, circle_radius = 30 / 2, hole_diameter = 2.2, hole_height = 12.3);
		}
	}
}

module bearing_housing_upper_output() {
	union() {
		difference() {
			translate([0, 0, 1/2]) {
				cylinder(h = 3, r = 20, center = true);
			}
			bearing_housing_upper_output_screw_holes();
		}
	}
}

module bearing_housing_upper() {
	union() {
		bearing_housing_upper_bracket();
		bearing_housing_upper_output();
	}
}

module bearing_housing_lower_bracket() {
	union() {
		translate([0, 0, 3 + 1.5]) {
			cylinder(h = 1, r = 6, center = true);
		}
		translate([0, 0, 1.5]) {
			cylinder(h = 5, r = 54 / 2, center = true);
		}
		translate([0, 0, 4]) {
			hollow_cylinder(outer_d = 43, inner_d = 28, h = 0.8);
		}
		translate([0, 0, 4]) {
			hollow_cylinder(outer_d = 54, inner_d = 50, h = 1);
		}
	}
}

module bearing_housing_lower_bracket_screw_holes() {
	union() {
		translate([0, 0, -1.1]) { // this needs to go on the cap. i am tired.
			bolt_circle(num_bolts = 2, circle_radius = 3, hole_diameter = 2.2, hole_height = 12);
		}
		translate([0, 0, -0.1]) {
			bolt_circle(num_bolts = 2, circle_radius = 6 / 2, hole_diameter = 3, hole_height = 1.2);
		}
		translate([0, 0, -1.1]) { // this needs to go on the cap. i am tired.
			bolt_circle(num_bolts = 6, circle_radius = 10, hole_diameter = 2.2, hole_height = 12);
		}
		translate([0, 0, 2.81]) {
			bolt_circle(num_bolts = 6, circle_radius = 10, hole_diameter = 3, hole_height = 1.2);
		}
	}
}


module bearing_housing_lower() {
	union() {
		difference() {
			bearing_housing_lower_bracket();
			bearing_housing_lower_bracket_screw_holes();
		}
	}
}

module gear_bearing_pulley() {
	union() {
		gear_bearing();
		translate([0, 58, 2]) bearing_housing_upper();
		translate([58, 0, 0]) bearing_housing_lower();
	}
}

*gear_bearing_pulley();

module gear_bearing_pulley_printable() {
	union() {
		translate([0, 0, 12]) rotate([0, 180, 0]) {
			gear_bearing();
		}
		translate([55, 0, 0]) rotate([0, 180, 0]) {
			bearing_housing_upper();
		}
		translate([0, 55, 0]) bearing_housing_lower();
	}
}

scale(1.5) gear_bearing_pulley_printable();
