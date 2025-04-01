module neo_27_1_import() {
	import(file = "../../../stl/neo_geared/27to1/neo_geared_27_to_1.stl", center = true, dpi = 96, convexity = 1);
}

module neo() {
    color("white", 0.9) { 
        translate(v = [0, 0, 122.1]) {
            neo_27_1_import(); 
        }
    }
}

module subtract_cyl() {
    translate([0, 0, (58.25) / 2]) cylinder(h = 58.25, r1 = (50.8) / 2, r2 = (50.8 / 2), center = false);
}

union() {
difference() {
    neo();
    
    subtract_cyl();
    translate([0, 0, (58.25) + (58.25) / 2]) cube([41.25, 39.9, 58.25], center = true);
}
}
