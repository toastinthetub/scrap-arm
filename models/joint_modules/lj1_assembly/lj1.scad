include <samSCAD/samstdlib.scad>
include <lib/lj1_old_lib.scad>
include <lib/hex-grid.scad>

module grid_bottom() {
	*translate([45/2, 0, 6/2]) rotate([0, 0, 0]) {
		create_grid(size=[191 - 51,46.75,6],SW=20,wall=4);
	}
	*translate([-45/2, 0, 51 - 6/2]) rotate([0, 0, 0]) {
		create_grid(size=[191 - 51,46.75,6],SW=20,wall=4);
	}
}

module bottom_lattice_structure() {
	difference() {
		union() {
			translate([65.5/2 - (14.2), 0, 6/2]) rotate([0, 0, 0]) {
				create_grid(size=[191 - 95,46.75,6],SW=10,wall=4);
			}

			translate([(-191/2) + 35 / 2, 0, 6/2]) rotate([0, 0, 0]) {
				*create_grid(size=[51/2,46.75,6],SW=5,wall=4);
			}

			// vert

			translate([(51-2)/2, 0, 51/2]) rotate([0, 90, 0]) {
				create_grid(size=[51 ,46.75,12],SW=5,wall=4);
			}

			translate([(191/2) - 50, 0, 51/2]) rotate([0, 45, 0]) {
				*create_grid(size=[51 - 12 ,46.75,6],SW=10,wall=4);
			}

			translate([(51-12)/2, 0, 51/2]) rotate([0, 90, 0]) {
				*create_grid(size=[51 - 12 ,46.75,6],SW=10,wall=4);
			}

			// evert

			translate([45/2, 0, 6/2]) rotate([0, 0, 0]) {
				*create_grid(size=[191 - 51,46.75,6],SW=20,wall=4);
			}
		}
		union() {
			translate([0, -(46.75/2) + (46.75/4), 51/2]) cube([191, 46.75/2, 24], center = true);
			
		}
	}
}

module top_lattice_structure() {
	difference() {
		union() {
			translate([-54/2, 0, 51 - (6/2)]) rotate([0, 0, 0]) {
				create_grid(size=[191 - 100,46.75,6],SW=10,wall=4);
			}
		}
		union() {
			
		}
	}
}

translate([0, 0, 0]) bottom_lattice_structure();
translate([0, 0, 0]) top_lattice_structure();

module yoke_obstruction_diff() {
	cube([36, 48, 100], center = true);
}

module final_everything() {
	difference() {
		union() {
			assembly();
			grid_bottom();
			
		}
		union() {
			translate([-95.5 + 48, 8, -51/3]) yoke_obstruction_diff();
			translate([35, 46.75-8-3, 51/2]) rotate([90, 0, 0]) sparkmax_pocket();
		}
	}
}

final_everything();
