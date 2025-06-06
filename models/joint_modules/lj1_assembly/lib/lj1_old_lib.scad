include <samSCAD/samstdlib.scad>
include <hex-grid.scad>

// STUPID LIB STUFF

$fn = 100;

// 608zz flanged bearing
module bearing_diff() {
	translate([0, 0, (1.11) - 0.01])union() {
		translate([0, 0, 7.9 / 2]) {
			cylinder(h = 9/*7.91*/, r = 28.575 / 2, center = true);
		}
		translate([0, 0, -(1.11/2)]) {
			cylinder(h = 1.11, r = 31.1 / 2, center = true);
		}
	}
}

// M3 screw bolt circle 32mm diameter
module neo_550_bolt_circle() {
	// big holes
	translate([0, 0, 0]) union() {
		translate([0, 0, 0]) {
			bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 3.32, hole_height = 20);
		}
		translate([0, 0, 20 / 2]) {
			cylinder(h = 20, r = (24 / 2) + 0.3, center = true);
		}
		// little holes
		translate([0, 0, 0]) {
			bolt_circle(num_bolts = 6, circle_radius = 32 / 2, hole_diameter = 6, hole_height = 1.5);
		}
	}
}

// 79
module hex_half_hole(h) {
	translate([0, 0, h]);
	cylinder(h = h, r = 12.7 / sqrt(3),$fn = 6, center = true);
}

module hex_end() {
	translate([0, 0, 8 / 2]) {
		rotate([0, 0, 90])
		cylinder(h = 8, r = 51 / 2, $fn = 6, center = true);
	}
}

module plate_raw() {
	difference() {
		translate([0, 0, 8 / 2]) {
			cube([191, 51, 8], center = true);
		}
		translate([191 / 2, 0, 0]) { // breaks if its 191. which should be correct. fuck.
			hex_end();
		}
		translate([-(191 / 2), 0, -0.1]) {
			*scale(1)hex_end();
		}
	}
	translate([191 / 2, 0, 0]) {
		hex_end();
	}
	translate([-(191 / 2), 0, 0]) {
		scale(1)hex_end();
	}
}

module SPECIAL_plate_raw() {
	difference() {
		union() {
			translate([0, 0, 8 / 2]) {
				create_grid(size=[191,51,8],SW=10,wall=3);
			}
			translate([0, (51/2) - (15/2), (8 / 2)]) {
				cube([191, 15, 8], center = true);
			}
			translate([0, -(51/2) + (15/2) , (8 / 2)]) {
				cube([191, 15, 8], center = true);
			}

			translate([(191/2) - (51/2) - 6, 0, (8 / 2)]) {
				cube([20, 51, 8], center = true);
			}

			translate([-14.5, 0, (8 / 2)]) {
				cube([10, 51, 8], center = true);
			}
		}

		translate([191 / 2, 0, 0]) { // breaks if its 191. which should be correct. fuck.
			hex_end();
		}
		translate([-(191 / 2), 0, -0.1]) {
			*scale(1)hex_end();
		}
	}
	translate([191 / 2, 0, 0]) {
		hex_end();
	}
	translate([-(191 / 2), 0, 0]) {
		scale(1)hex_end();
	}
}

module plate_hex_ends() {
	difference() {
		plate_raw();
		translate([-(191 / 2), 0, 0]) {
			*hex_half_hole(h = 16.1);
		}
		translate([(191 / 2) /*fuckity*/ - (14.2) + 3/*unfuckity*/, 0, 8]) rotate([180, 0, 0]) {
			bearing_diff();
		}
	}
}

// HERE line 81

module SPECIAL_plate_hex_ends() {
	difference() {
		SPECIAL_plate_raw();
		translate([-(191 / 2), 0, 0]) {
			*hex_half_hole(h = 16.1);
		}
		translate([(191 / 2) /*fuckity*/ - (14.2) + 3/*unfuckity*/, 0, 8]) rotate([180, 0, 0]) {
			bearing_diff();
		}
	}
}


module small_neo_pocket() {
	translate([0, 0, 1 / 2]) {
		cylinder(h = 1.0, r = 38 / 2, $fn = 6, center = true);
	}
}


// END STUPID LIB STUFF ======================================================

module sides_lol() {
	translate([(191 / 2),  -((51 / 2) - (6 / 2)), 0]) rotate([270, 180, 90]) {
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
					ramp(width=((191/2) - (-14.2 + (45 / 2))) + 2, height=8, depth=45);		
				}
			}
			translate([(191/2), 0, 8 / 2]) {
				cylinder(h = 9/*7.91*/, r = 28.575 / 2, center = true);
			}
			translate([191/2, 0, -3]) {
				three_hex_ends();
			}
		}
	}
}

module inverse_neo_front_ramp_diff() {
	union() {
		translate([(191 / 2) - (87.2 / 2), 0, 0]) { 
			difference() {
				translate([0, 0, 8 / 2]) {
					cube([(191/2) - 8.3/*89.2/*((191/2) - (-14.2 + (51/ 2))) + 0*/, 53, 8], center = true);
				}
				translate([(-87.2 / 2), ((51 / 2)), 0]) rotate([90, 0, 0]) {
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

			// front ramp
			translate([0, 0, 8]) {
				neo_plate_front_ramp();
				difference() {
					rotate([0, 0, 0]) translate([0, 0, 0]) sides_lol();
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
			translate([-14.2, 0, 16 - (5.529)]) rotate([0, 0, 0]) {
				neo_plate_box_diff_inner();
			}
			translate([-14.2, 0, ((16 - 5.53) - 2/2) + 0.01]) {
				cylinder(h = 2, r = 19, center = true);
			}
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
		translate([(-191 / 2), 0, 8]) {
			three_hex_ends();	
		}
		translate([(-191 / 2) - (51 / 2), 0, (8+ 8/2) - 0.01]) {
			cube([51, 51, 8], center = true);
		}
	}
}

module neo_side_THISISNOWAHELPER() {
	difference() {
		// MODEL TO SUBTRACT FROM
		union() {
			neo_side_helper();
		}
		// SUBTRACTION
		union() {
			hex_diffs();
			translate([-14.2, 0, -0.1]) {
				neo_550_bolt_circle();
			}
		}
	}
}

module sparkmax_pocket() {
	union() {
		difference() {
			union() {
				translate([0, 0, 10/2]) rotate([0, 0, 0]) {
						cube([69.5, 34.8, 10], center = true);
				}
			}
			union() {
				
			}
		}
	}
}

module tensioner_end_diff() {
	translate([0, 0, 0])union() {
		translate([0, 0, 18/2]) rotate([0, 0, 0]) {
			cube([51/2, 1, 18], center = true);
		}
		translate([0, 0, (16/2)]) rotate([90, 0, 0]) {
			cylinder(h = 70, r=3.4/2, center = true);
			translate([0, 0, -(50/2) -10.75]) {
				cylinder(h = 50, r=6/2, center = true);
			}
			translate([0, 0, (50/2) + 10.75]) {
				cylinder(h = 50, r=6/2, center = true);
			}
		}
		translate([0, -7.99, (16/2)]) rotate([90, 0, 0]) {
			m3_nut_trap(w = 4.3, h = 2.8);
		}
	}
}

module routing_holes() {
	translate([0, 0, 100/2]) rotate([0, 0, 0]) { cube([8, 15, 100], center = true); }
	translate([0, (15/4) + 1, 100/2]) rotate([0, 0, 0]) { cylinder(h = 100, r=5, center = true); }
	translate([0, (-15/4) - 1, 100/2]) rotate([0, 0, 0]) { cylinder(h = 100, r=5, center = true); }
}

module yet_another_lazy_helper_function() {
	union() {
		difference() {
			union() {
				neo_side_THISISNOWAHELPER();
				translate([(-191 / 2), 0, 7.99]) {
					scale(1)hex_end();
				}
			}
			union() {
				translate([-(191/2), 0, 8]) hex_half_hole(h = 25);
				translate([-(191/2) - 51/4, 0, -0.02]) tensioner_end_diff();
				*translate([-48 - (14.2/2), 0, 8]) rotate([0, 0, 90]) %sparkmax_pocket();
			}
		}
	}

}

module abacus() {
	translate([191/2, 0, 8/2 + 8]) rotate([0, 0, 0]) {
			cylinder(h = 8, r1 = (191/4) - 2, r2 = (191/4) + 10, $fn = 18, center = true);
			bearing_diff();
	}
}


module neo_side() {
	union() {
		difference() {
			union() {
				yet_another_lazy_helper_function();
				translate([-191/2, 0, -(7.9999*6) + 0.6]) {
					difference() {
						union() {
							three_hex_ends();
							translate([0, 0, -(7.9999) + 0.6]) {
									three_hex_ends();
							}
						}
						hex_half_hole(h = 125);
					}
				}
			}
			translate([(192/2) - 35, 0, -50/2]) rotate([0, -35, 0]) {
				routing_holes();
			}
			translate([(192/2) - 60, 0, -25/2]) rotate([0, -35, 0]) {
				scale(0.5) routing_holes();
			}
			scale(1) translate([-70, 0, -15]) rotate([0, 30, 0]) {
				translate([0, 5, 0]) routing_holes();
				translate([0, -5, 0]) routing_holes();
			}
			scale(0.7) translate([-100, 0, -15]) rotate([0, 30, 0]) {
				translate([0, 0, 0]) routing_holes();
				translate([0, 0, 0]) routing_holes();
			}
			translate([191/2, 0, 7.9999]) {
				three_hex_ends();
				
			}
			abacus();
			translate([(-191/2) + 30, 55/2, (45/2) - (30/2)]) rotate([90, 0, 0]) {
				*oval_cylinder(28, 30, 55); 
			}
		}
	}
}

module bearing_side_helper() {
	difference() {
		SPECIAL_plate_hex_ends();
	}
}

module bearing_side() {
	difference() {
		union() {
			bearing_side_helper();
		}
		union() {
			translate([-(191/2), 0, 8]) hex_half_hole(h = 25);
			translate([-(191/2) - 51/4, 0, -4]) tensioner_end_diff();
			*translate([-14.2, 0, 8]) rotate([180, 0, 0])bearing_diff();
		}
	}
}

module a_fucking_shitload_of_hex_shaft() {
	translate([0, 80, 40.75/2]) {
		hex_half_hole(h = 40.75);
	}
	translate([20, 80, 60.75/2]) {
		hex_half_hole(h = 60.75);
	}
	translate([-20, 80, 50.75/2]) {
		hex_half_hole(h = 50.75);
	}
	translate([40, 80, 60.75/2]) {
		hex_half_hole(h = 60.75);
	}
	translate([-40, 80, 50.75/2]) {
		hex_half_hole(h = 50.75);
	}

}

module next_link_plate_placeholder() {
	difference() {
		union() {
			hex_end();
		}
					hex_half_hole(h = 20);

	}
}

module debug() {
	translate([0, (50/2) +4, 0]) rotate([0, 0, 0]) {
		neo_side();
	}
	translate([0, (-50/2) -4, 0]) rotate([0, 0, 0]) {
		bearing_side();
	}
	translate([0, (-80) -4, 0]) rotate([0, 0, 0]) {
		next_link_plate_placeholder();
	}
	scale(0.999)a_fucking_shitload_of_hex_shaft();
}

module double_debug() {
	translate([0, 0, 0]) {
		neo_side();
	}
}

// FULL ASSEMBLY
module assembly() {
	translate([0, -(46.75 / 2), 51 / 2]) rotate([90, 0, 0]) {
		//neo_side();
		difference() {
			neo_side();
		}
	}
	translate([0, (46.75/2) + 8, 51 / 2]) rotate([90, 0, 0]) {
		bearing_side();
	}
}

*assembly();
*debug();

*double_debug();
