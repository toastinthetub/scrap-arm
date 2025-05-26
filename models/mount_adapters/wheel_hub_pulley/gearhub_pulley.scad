include <pulley-generator.scad>;
//include <gearhub_pulley_old.scad>;
include <samSCAD/samstdlib.scad>;

module sprocket_raw() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 105, 
		beltWidth = 9, 
		shaftDiameter = 48, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

// BIG HOLES
module sprocket_big_bolt_holes() {
	translate([0, 0, -0.1]) {
		bolt_circle(num_bolts = 4, 
			circle_radius = 72 / 2, 
			hole_diameter = 10, 
			hole_height = 25
		);
	}
	translate([0, 0, 0]) {
		bolt_circle(num_bolts = 4, 
			circle_radius = 72 / 2, 
			hole_diameter = 14.2, 
			hole_height = 7.7
		);
	}
}

// LITTLE HOLES
module sprocket_little_bolt_holes() {
	translate([0, 0, -2]) {
		rotate([0, 0, 0]) {
			bolt_square(num_x = 2,
				num_y = 2,
				spacing_x = 40, 
				spacing_y = 70, 
				hole_diameter = 6, 
				hole_height = 25
			);
		}
	}
	translate([0, 0, -2]) {
		rotate([0, 0, 45]) {
			bolt_square(num_x = 2, 
				num_y = 2, 
				spacing_x = 20, 
				spacing_y = 78, 
				hole_diameter = 6.2, 
				hole_height = 25
			);
		}
	}
}

module sprocket() {
	difference() {
		/* DEBUG
		translate([0, 0, 13 / 2]) {
			$fn = 8;
			cylinder(h = 1, r = 102.27 / 2, center = true);
		} */
		
		
		sprocket_raw();
		cylinder(h = 40, r = 48.2 / 2, center = true);
		
		// diff with the screw holes
		union() {
			rotate([0, 0, 0]) {
				*sprocket_little_bolt_holes();
			}
			rotate([0, 0, 0]) {
				sprocket_big_bolt_holes();
			}
		}
	}
}

module drive_raw() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 35, 
		beltWidth = 9, 
		shaftDiameter = 25, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

module drive() {
	difference() {
		
	}
}

module both_test() {
	translate([0, 0, 0]) {
		sprocket();
	}
	translate([0, 0, 0]) {
		drive();
	}
}

both_test();


*hollow_cylinder(outer_d = 50, inner_d = 48, h = 10);

