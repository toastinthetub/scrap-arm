module neo_27_1_import() {
	import(file = "../../../stl/neo_geared/27to1/neo_geared_27_to_1.stl", center = true, dpi = 96, convexity = 1);
}

module neo() {
    color("white", 1) { 
        translate(v = [0, 0, 122.1]) {
            neo_27_1_import(); 
        }
    }
}

// module subtract_cyl() {
//     translate([0, 0, (58.25) / 2]) cylinder(h = 58.25, r1 = (50.8) / 2, r2 = (50.8 / 2), center = false);
// }

// union() {
// difference() {
//     neo();
    
//     subtract_cyl();
//     translate([0, 0, (58.25) + (58.25) / 2]) cube([41.25, 39.9, 58.25], center = true);
// }
// }

module diffthing() {
    translate([0, 0, 1]) cylinder(h = 109, r1 = 20, r2 = 20);
}


    neo();

    diffthing();


module pyramid(base=120, height=120) {
    polyhedron(
        points=[
            [0, 0, 0],          // Base corner 1
            [base, 0, 0],       // Base corner 2
            [base, base, 0],    // Base corner 3
            [0, base, 0],       // Base corner 4
            [base/2, base/2, height] // Apex
        ],
        faces=[
            [0, 1, 4],  // Side 1
            [1, 2, 4],  // Side 2
            [2, 3, 4],  // Side 3
            [3, 0, 4],  // Side 4
            [0, 1, 2, 3] // Base
        ]
    );
}

// Example usage:
pyramid(20, 15);
