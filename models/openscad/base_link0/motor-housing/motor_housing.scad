use <../base-plate/base_plate.scad>;

$fn = 100;

translate([0, 0, - (5 / 1)]) base_plate();

module bearing_riser() {
	color("red") {
		union() {
			translate([0, 0, (159 / 2)]) {
				cylinder(h = 159, r1 = 35, r2 = 35, center = true);
			}
			translate([0, 0, (12 / 2)]) {
				cylinder(h = 12, r1 = 50, r2 = 50, center = true);
			}
		}
	}
}

bearing_riser();
