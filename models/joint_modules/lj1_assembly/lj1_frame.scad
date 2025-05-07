use <samSCAD/samstdlib.scad>

// frame. should have screw holes for the 

translate([0, 0, 56/2]) { 
	color("red")
	hex_shaft(hex_d = 12.7 / 2, length = 46 + 10);
}

translate([0, (8 * 2), 50/2]) {
	color("blue") 
	hex_shaft(hex_d = 12.7 / 2, length = 50);
}

translate([0, (8 * 4), 50/2]) {
	color("green") 
	hex_shaft(hex_d = 12.7 / 2, length = 50);
}

translate([0, -(8 * 2), 66 / 2]) {
	color("red")
	hex_shaft(hex_d = 12.7 / 2, length = 56 + 10);
}

translate([0, -(8 * 4), 76 / 2]) {
	color("red")
	hex_shaft(hex_d = 12.7 / 2, length = 66 + 10);
}

