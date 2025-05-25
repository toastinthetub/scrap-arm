include <samSCAD/samstdlib.scad>
include <lj1.scad>
include <hex-grid.scad>

module grid_top() {
	translate([-45/2, 0, 6/2]) rotate([0, 0, 0]) {
		create_grid(size=[191 - 51,46.75,6],SW=20,wall=4);
	}
	translate([-45/2, 0, 51 - 6/2]) rotate([0, 0, 0]) {
		create_grid(size=[191 - 51,46.75,6],SW=20,wall=4);
	}
}

grid_top();
