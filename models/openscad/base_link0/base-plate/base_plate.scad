$fn = 100;

module plate() {
	translate([0, 0, (5 / 2)]) {
		cube([200, 200, 5], center = true);
	}
}

module screw_holes() {
	union() {
		translate([80, 80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([80, -80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([-80, 80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
		
		translate([-80, -80, -0.1]) {
			cylinder(h = 5.2, r1 = (8.5) / 2, r2 = (8.5 / 2));
		}
	}
}

module base_plate() {
	union() {
		difference() {
			plate();

			screw_holes();
		}
	}
}

base_plate();
