include <pulley-generator.scad>;
include <samSCAD/samstdlib.scad>;

module sprocket_raw_OLD() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 105, 
		beltWidth = 9, 
		shaftDiameter = 48, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

module sprocket_OLD() {
	difference() {
		*sprocket_raw_OLD();
		translate([0, 0, 13 / 2]) {
			$fn = 8;
			cylinder(h = 1, r = 102.27 / 2, center = true);
		}
		cylinder(h = 40, r = 48.2 / 2, center = true);

		union() {
			*translate([0, 0, -0.01]) {
				bolt_square(
					num_x = 2, 
					num_y = 2, 
					spacing_x = 57 - (9 / 2), 
					spacing_y = 57 - (9 / 2), 
					hole_diameter = 14.1, 
					hole_height = 9.5
					);
			}
			translate([0, 0, 0]) {
				bolt_square(
					num_x = 2, 
					num_y = 2, 
					spacing_x = 57 - (9 / 2), 
					spacing_y = 57 - (9 / 2), 
					hole_diameter = 9, 
					hole_height = 25
					);
			}
			translate([0, 0, -2]) {
				rotate([0, 0, 45])
				bolt_square(num_x = 2, num_y = 2, spacing_x = 37, spacing_y = 75 - (6 / 2), hole_diameter = 6, hole_height = 16);
			}
		}
	}
}

module drive_raw_OLD() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 35, 
		beltWidth = 9, 
		shaftDiameter = 25, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

module drive_OLD() {
	difference() {
		
	}
}

module both_test_OLD() {
	translate([0, 0, 0]) {
		sprocket_OLD();
	}
	translate([0, 0, 0]) {
		drive_OLD();
	}
}

translate([0, 0, 7]) {
	rotate([0, 0, 45]) {
		%both_test_OLD();
	}
}

*hollow_cylinder(outer_d = 50, inner_d = 48, h = 10);
