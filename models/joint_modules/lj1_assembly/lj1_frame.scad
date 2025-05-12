use <samSCAD/samstdlib.scad>

// frame. should have screw holes for the 

DEBUG_CLEARANCE = 10;

// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3, hole_height = 8);
}

// outer frame, big focken rectangle
module link_one_frame_outer() {
	cube([51, 51, 217], center = true);
}

// inner diff, to make this hollow
module link_one_frame_diff() {
	cube([35, 35, 217 + DEBUG_CLEARANCE], center = true);
}

// 608zz flanged bearing
module bearing_diff() {
	translate([0, 0, 7.9 / 2]) {
		cylinder(h = 7.91, r = 28.575 / 2, center = true);
	}
	translate([0, 0, 1.1 / 2]) {
		cylinder(h = 1.11, r = 31.1 / 2, center = true);
	}
}

module bearing_holes_length() {
	translate([0, 0, 0,]) {
		
	}
	translate([0, 0, 0,]) {
		
	}
}

module fulcrum_bearing_end() {
	difference() {
		translate([0, 0, 7.9 / 2]) {
			cylinder(h = 7.9, r = 51 / 2, center = true);
		}
		translate([0, 0, 0]) {
			bearing_diff();
		}
	}
}

module link_one_frame() {
	union() translate([0, 0, 0]) rotate([0, 0, 0,]) {
		difference() {
			link_one_frame_outer();
			link_one_frame_diff();
		}
	}
}

*link_one_frame();

fulcrum_bearing_end();
*bearing_diff();
