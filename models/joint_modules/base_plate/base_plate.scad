use <samSCAD/samstdlib.scad>

// base plate dimensions
base_plate_square = 240;
base_plate_height = 5;

circumscribed_diameter = sqrt(2) * base_plate_square;

// to be diffed, outer 4 m10 bolts.
module base_plate_outer_bolt_square_DIFF() {
	union() {
		translate([0, 0, -10 / 2 + 1]) {
			bolt_square(num_x = 2, num_y = 2, spacing_x = 160, spacing_y = 160, hole_diameter = 8.5, hole_height = 10);
		}
	}
}

module base_plate_raw() {
	union() {
	difference() {
			translate([0, 0, base_plate_height / 2]) {
				cube([base_plate_square, base_plate_square, base_plate_height], center = true);
			}
			translate([0, 0, (10 / 2) - 0.1]) {
				hollow_cylinder(
					outer_d = circumscribed_diameter,
					inner_d = circumscribed_diameter - 90,
					h = 10, 
					center = true,
					$fn = 150
				);
			}
		}
	}
}

// solid plate with 4 bolt m10x1.5 bolt holes. 
// maybe i'll make a version with a nut trap in the top.
module base_plate() {
	union() {
		difference() {
			base_plate_raw();

			base_plate_outer_bolt_square_DIFF();
		}
	}
}

base_plate();
