include <samSCAD/samstdlib.scad>

// STUPID LIB STUFF

$fn = 100;

// 608zz flanged bearing
module bearing_diff() {
	translate([0, 0, 7.9 / 2]) {
		cylinder(h = 9/*7.91*/, r = 28.575 / 2, center = true);
	}
	translate([0, 0, 1.1 / 2]) {
		cylinder(h = 1.11, r = 31.1 / 2, center = true);
	}
}

// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	// big holes
	translate([0, 0, 0.5]) {
		bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3.25, hole_height = 20);
	}
	translate([0, 0, 10 / 2]) {
		cylinder(h = 20, r = (24 / 2) + 0.3, center = true);
	}
	// little holes
	translate([0, 0, (0.5) / 2]) {
		bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 5.3, hole_height = 0.5);
	}
}


// HERHEHREHREHRHEREHREHREHREHRHERHERHEHR
translate([0, 50, 0]) {
	neo_550_bolt_circle();
}

module hex_half_hole(h) {
	translate([0, 0, h]);
	cylinder(h = h, r = 12.7 / sqrt(3),$fn = 6, center = true);
}

module hex_end() {
	translate([0, 0, 8 / 2]) {
		rotate([0, 0, 90])
		cylinder(h = 8.03, r = 51 / 2, $fn = 6, center = true);
	}
}

module plate_raw() {
	difference() {
		translate([0, 0, 8 / 2]) {
			cube([192, 51, 8], center = true);
		}
		translate([192 / 2, 0, 0]) {
			hex_end();
		}
		translate([-(192 / 2), 0, 0]) {
			hex_end();
		}
	}
	translate([192 / 2, 0, 0]) {
		hex_end();
	}
	translate([-(192 / 2), 0, 0]) {
		hex_end();
	}
}

module plate_hex_ends() {
	difference() {
		plate_raw();
		translate([-(192 / 2), 0, 0]) {
			hex_half_hole(h = 16.1);
		}
		translate([(192 / 2), 0, 7.9]) rotate([180, 0, 0]) {
			bearing_diff();
		}
	}
}

module small_neo_pocket() {
	translate([0, 0, 0.5 / 2]) {
		cylinder(h = 0.5, r = 38 / 2, $fn = 6, center = true);
	}
}


// END STUPID LIB STUFF ======================================================

module sides_lol() {
	translate([(191 / 2),  -((51 / 2) - 6 / 2), 0]) rotate([270, 180, 90]) {
		ramp(width=3, height=8, depth=191);		
	}
	translate([-(191 / 2),  ((51 / 2) - 6 / 2), 0]) rotate([270, 180, 270]) {
		ramp(width=3, height=8, depth=191);		
	}
}

// LMFAO
module three_hex_ends() {
	translate([0, 0, 0]) {
		hex_end();
	}
	translate([0, 0, 8]) {
		hex_end();
	}
	translate([0, 0, 16]) {
		hex_end();
	} 
}

module neo_plate_back_ramp() {
	union() {
		difference() {
				union() {
				translate([(-45 + 14.2) -5.90, -45/2, 8]) rotate([90, 0, 180]) {
					ramp(width=((191/2) - (-14.2 + (45 / 2))), height=8, depth=45);		
				}
			}
		}
	}
}

module neo_plate_front_ramp() {
	union() {
		difference() {
				union() {
				translate([-14.2 + (45 / 2), (51 / 2) - 5 + 2, 0]) rotate([90, 0, 0]) {
					ramp(width=((191/2) - (-14.2 + (45 / 2))), height=8, depth=45);		
				}
			}
		}
	}
}

module inverse_neo_front_ramp_diff() {
	union() {
		translate([(191 / 2) - (87.2 / 2), -0.5, 0]) { 
			difference() {
				translate([0, 0, 8 / 2]) {
					cube([89.2/*((191/2) - (-14.2 + (51/ 2))) + 0*/, 51, 8], center = true);
				}
				translate([(-87.2 / 2) - 1, ((51 / 2) + 0.5), 0]) rotate([90, 0, 0]) {
					ramp(width=((191/2) - (-14.2 + (45 / 2))) + 2, height=8, depth=51);		
					
				}
			}
		}
	}
}

module neo_plate_box_diff_inner() {
	union() {
		translate([0, 0, 5.53 / 2])
		cube([43.5, 43.5, 5.53], center = true);
	}
}

module neo_plate_box_extrude() {
	difference() {
		// FIRST UNION
		union() {
			translate([-14.2, 0, 12]) {
				cube([45, 45, 8], center = true);
			}
			translate([-14.2 + (45 / 2), -(51 / 2) + 6 / 2, 8]) rotate([270, 180, 90]) {
				ramp(width=3, height=8, depth=45);		
			}
			translate([-14.2 - (45 / 2), (51 / 2) - (6 / 2) , 8]) rotate([270, 180, 270]) {
				ramp(width=3, height=8, depth=45);		
			}

			translate([-14.2, 0, 16]) {
				neo_550_bolt_circle();
			}

			// front ramp
			translate([0, 0, 8]) {
				neo_plate_front_ramp();
				difference() {
					sides_lol();
					translate([0, 0, 0])
					inverse_neo_front_ramp_diff();
				}
			}
			// back ramp
			translate([0, 0, 0]) {
				neo_plate_back_ramp();
			}
		}
		// NEXT THING

		union() {
			translate([-14.2, 0, 16 - (5.529)]) rotate([0, 0, 0])
			neo_plate_box_diff_inner();
		}
		
	}
}

// this is gonna be the plate that goes on top of the other plate.
/*
module neo_rawish_helper() {
	union() {
		translate([-14.2, 0, 12]) {
			*cube([45, 45, 8], center = true);
		}
		translate([0, 0, 0]) {
			//
		}
	}
} */

module neo_side_rawish() {
	translate([0, 0, 8]) rotate([180, 0, 0]) plate_hex_ends();
	translate([0, 0, 0]) rotate([0, 0, 0]) neo_plate_box_extrude();
	*translate([0, 0, 8]) rotate([0, 0, 0]) plate_hex_ends();	
}

module neo_side_helper() {
	// the now has a 1/2 inch hex hole and a spot for a press fit bearing
	difference() {
		/*plate_hex_ends();
		translate([-14.2, 0, 7.501])small_neo_pocket(); */

			neo_side_rawish();
	}
}

module hex_diffs() {
	union() {
		translate([191 / 2, 0, 8.01]) {
			three_hex_ends();
		}
		translate([-191 / 2, 0, 8]) {
			three_hex_ends();
		}
		translate([(-191 / 2) - (51 / 2), 0, (8+ 8/2) - 0.01]) {
			cube([51, 51, 8], center = true);
		}
	}
}

module neo_side() {
	difference() {
		// MODEL TO SUBTRACT FROM
		union() {
			neo_side_helper();
		}
		// SUBTRACTION
		union() {
			hex_diffs();
		}
	}
}

module bearing_side_helper() {
	difference() {
		plate_hex_ends();
	}
}

module bearing_side() {
	difference() {
		union() {
			bearing_side_helper();
		}
		union() {
			
		}
	}
}

module debug() {
	translate([0, 50, 0]) rotate([0, 0, 0]) {
		neo_side();
	}
	translate([0, -50, 0]) rotate([0, 0, 0]) {
		bearing_side();
	}
}

module double_debug() {
	translate([0, 0, 0]) {
		neo_side();
	}
}

// FULL ASSEMBLY
module assembly() {
	translate([0, -(16.75 / 2), 51 / 2]) rotate([90, 0, 0]) {
		neo_side();
	}
	translate([0, (16.75 / 2), 51 / 2]) rotate([270, 0, 0]) {
		bearing_side();
	}
}

*assembly();
*debug();

double_debug();
