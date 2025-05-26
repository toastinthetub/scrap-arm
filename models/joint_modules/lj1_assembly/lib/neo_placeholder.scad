module hex_of_p2p_r_n(h = 1, n = 1) {
	cylinder(h = n, r = n / sqrt(3), $fn = 6, center = true);
}

module motor_end() {
	translate([0, 0, 8.50]) {
		cylinder(h = 37, r = 35 / 2);
	}
	translate([0, 0, 0]) {
		cylinder(h = 8.50, r2 = 35 / 2, r1 = 20.056 / 2);
	}
}

module ultraplanetary_gearbox() {
	translate([0, 0, (46 / 2) + (44.146)]) {
		hex_of_p2p_r_n(h = 46, n = 43.301);
	}
}

module neo_550() {
	motor_end();
	ultraplanetary_gearbox();
}

neo_550();
