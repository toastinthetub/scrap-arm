use <samSCAD/samstdlib.scad>

use <../joint_modules/base_plate.scad>
// use <../mount_adapters/>
// use <../gearboxes/>

// BASE PLATE DIMENSIONS
BASE_PLATE_HEIGHT = 5;
BASE_PLATE_SQUARE  = 240;
BASE_PLATE_DIFF_CYL_OD = 340;

// base assembly including plate, bearings, etc
module base_assembly() {
	union() {
		translate([0, 0, 0]) {
			// the base plate is already translated up
			base_plate();
		}
	}
}

base_assembly();
