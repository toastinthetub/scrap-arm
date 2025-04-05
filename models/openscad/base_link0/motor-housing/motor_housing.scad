use <../base-plate/base_plate.scad>;
use <../RESOURCE_3MF/slewing_ring.3mf>;

$fn = 100;

color("#818589") {
	translate([0, 0, - (5 / 1)]) base_plate();
}
module bearing_riser() {
	color("#E3E8EC") {
		union() {
			translate([0, 0, (122.45 / 2)]) {
				cylinder(h = 122.45, r1 = 35, r2 = 35, center = true);
			}
			translate([0, 0, (12 / 2)]) {
				cylinder(h = 12, r1 = 50, r2 = 50, center = true);
			}
		}
	}
}

translate([0, 0, 128]) {
	import("../RESOURCE_3MF/slewing_ring.3mf");
}

bearing_riser();
