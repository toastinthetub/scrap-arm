include <pulley-generator.scad>;

module drive_raw() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 25, 
		beltWidth = 9, 
		shaftDiameter = 0, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

*drive_raw();

module drive() {
	difference() {
		drive_raw();
		%cylinder(h = 60, r = 12.7 / sqrt(3), $fn = 6, center = true);
		translate([0, 0, 17.5]) {
			cylinder(h = 9, r = 10.1, center = true);
		}
	}
}

drive();

module l1_raw() {
	pulley3DP(
	  model = "HTD 3mm",
		teethCount = 24, 
		beltWidth = 9, 
		shaftDiameter = 0, 
		toothWidthTweak = 0.2, 
		toothDepthTweak = 0
	);
}

*l1_raw();
