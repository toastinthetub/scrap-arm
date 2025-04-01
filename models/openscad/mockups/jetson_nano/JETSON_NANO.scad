// nano has width 100mm, 80mm, 29m
nano_full_height = 29;

nano_width = 100;
nano_depth = 80;

nano_pcb_height = 1.62;

module pcb_material() {
	union() {
		translate([0, 0, (nano_pcb_height) / 2]) { // anchored to z = 0
			cube([100, 80, 1.62], center = true); // base pcb size is 1.62 mm tall
		}
	}
}

module screw_holes() {
	union() {
		translate([0, 0, 0]) {
			cylinder(h = (nano_full_height - nano_pcb_height), r1 = 1, r2 = 1, center = true );
		}
	}
}

module jetson_nano() {
	union() {
		pcb_material();
		screw_holes();
	}
}

jetson_nano();

