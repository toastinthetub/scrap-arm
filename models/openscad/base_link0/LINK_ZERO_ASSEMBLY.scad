/* 
Link zero of the scrap arm:
*/

module jetson_nano_import() {
	import(file = "../../stl/jetson-nano/jetson-nano.stl", center = true, dpi = 96, convexity = 1);
}

module neo_27_1_import() {
	import(file = "../../stl/neo_geared/27to1/neo_geared_27_to_1.stl", center = true, dpi = 96, convexity = 1);
}

// cube([190, 200, 20], center = true);

color("gray") {
	translate([0, 0, 20]) rotate([90, 0, 0]) jetson_nano_import();
}

color("red") {
	translate([0, 0, 20]) rotate([0, 0, 0]) neo_27_1_import();
}