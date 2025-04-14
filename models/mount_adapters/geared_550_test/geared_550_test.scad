use <samSCAD/samstdlib.scad>

$fn = 100;

gearbox_height = 45;
neo_height = 45;
base_height = 3;


module base_helper() {
	union() {
		difference() {
			translate([0, 0, 3/2]) {
				cube([38, 38, 3], center = true);
			}
			translate([0, 0, -6]) {
				rotate([0, 0, 45]) {
					bolt_square(num_x = 2, num_y = 2, spacing_x = 30, spacing_y = 30 , hole_diameter = 2.2, hole_height = 12);
				}
			}
		}
		translate([0, 0, 3/2]) {
			cube([48, 15, 3], center = true);
		}
		translate([0, 0, 3/2]) {
			cube([15, 48, 3], center = true);
		}
	}
}

module base() {
	union() {
		difference() {
			base_helper();
			
			translate([0, 0, -0.01]) {
				rotate([0, 0 , 0]) {
					scale(1.007) nut_trap_circle(4, 42.1 / 2, "m2");
				}
			}
			translate([0, 0, -6]) {
				rotate([0, 0, 45]) {
					bolt_square(num_x = 2, num_y = 2, spacing_x = 30, spacing_y = 30 , hole_diameter = 2.2, hole_height = 12);
				}
			}
			translate([0, 0, 2 + (1/2) + 0.01]) {
				cylinder(h = 1.01, r = 18 / 2, center = true);			
			}
		}
	}
}

module pillars() {
	union() {
		translate([(38 / 2) - 3/2, (38 / 2) - 3/2, 90 / 2 + base_height]) {
			cube([3, 3, 90], center = true);
		}
		translate([-(38 / 2) + 3/2, (38 / 2) - 3/2, 90 / 2 + base_height]) {
				cube([3, 3, 90], center = true);
		}
		translate([(38 / 2) - 3/2, -(38 / 2) + 3/2, 90 / 2 + base_height]) {
			cube([3, 3, 90], center = true);
		}
		translate([-(38 / 2) + 3/2, -(38 / 2) + 3/2, 90 / 2 + base_height]) {
			cube([3, 3, 90], center = true);
		} 
	}
}

module neo_cylindrical_enclosure_holes() {
	union() {
		translate([0, 0, 6 / 2]) {
			translate([0, 0, 0]) {
				rotate([90, 0, 0]) {
					%cylinder(h = 100, r = 6 / 2, center = true);
				}
			}
		}
		translate([0, 0, 6 / 2]) {
			translate([10, 0, 0]) {
				rotate([90, 0, 0]) {
					%cylinder(h = 100, r = 6 / 2, center = true);
				}
			}
		}
		translate([0, 0, 6 / 2]) {
			translate([-10, 0, 0]) {
				rotate([90, 0, 0]) {
					%cylinder(h = 100, r = 6 / 2, center = true);
				}
			}
		}
		translate([0, 0, 6 / 2]) {
			translate([0, 0, 9]) {
				rotate([90, 0, 0]) {
					%cylinder(h = 100, r = 6 / 2, center = true);
				}
			}
		}
	}
}

module neo_cylindrical_enclosure() {
	union() {
		difference() {
			translate([0, 0, (44.5 / 2) + 3]) {
				cylinder(h = 44.5, r = 37 / 2, center = true);
			}
			translate([0, 0, (44.5 / 2) + 3]) {
				cylinder(h = 44.7, r = 35 / 2, center = true);
			}
			translate([0, 0, 6 / 2]) {
				translate([0, 0, 0]) {
					rotate([90, 0, 0]) {
						%cylinder(h = 100, r = 6 / 2, center = true);
					}
				}
			}
			translate([0, 0, 6 / 2]) {
				translate([10, 0, 0]) {
					rotate([90, 0, 0]) {
						%cylinder(h = 100, r = 6 / 2, center = true);
					}
				}
			}
			translate([0, 0, 6 / 2]) {
				translate([-10, 0, 0]) {
					rotate([90, 0, 0]) {
						%cylinder(h = 100, r = 6 / 2, center = true);
					}
				}
			}
			translate([0, 0, 6 / 2]) {
				translate([0, 0, 9]) {
					rotate([90, 0, 0]) {
						%cylinder(h = 100, r = 6 / 2, center = true);
					}
				}
			}
		}
	}
}

module geared_550_test() {
	union() {
		base();
		pillars();
		neo_cylindrical_enclosure();
	}
}

geared_550_test() {
	
}
