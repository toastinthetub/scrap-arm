use <../base_plate/base_plate.scad>;
use <../riser_base/riser_base.scad>;
use <../riser_upper/riser_upper.scad>;
use <../full_asm/LINK_ZERO_ASSEMBLY.scad>;


module bolt_circle(num_bolts, circle_radius, hole_diameter, hole_height) {
    for (i = [0:num_bolts-1]) {
        angle = i * 360 / num_bolts;
        x = circle_radius * cos(angle);
        y = circle_radius * sin(angle);
        translate([x, y, 0]) {
            cylinder(h = hole_height, d = hole_diameter);
        }
    }
}

$fn = 100;

module riser_cover_helper_a() {
	translate([0, (65 / 2), (139.45) / 2]) {
		cube([105, 105, 134.45], center = true);
	}		
	translate([0, (65 / 2), 3 / 2]) {
		cube([120, 120, 3], center = true);
	} 
}

module motor_housing_helper_a() {
	difference() {
		translate([0, -(65 / 2), (134.45) / 2]) {
			cube([74, 64, 134.45], center = true);
		}
		translate([0, -(65 / 2) + 5, (136.45) / 2]) {
			cube([70, 70, 136.45], center = true);
		}
	}
}

module riser_cover() {
	union() {
		difference() {
			riser_cover_helper_a();
			translate([0, (65 / 2) - 5, (200 / 2) - 2]) {
				cube([100, 110, 200], center = true);
			}
		}
	}
}

%riser_cover();

motor_housing_helper_a();

translate([0, 0, -5]) base_plate();
link_zero_assembly();
