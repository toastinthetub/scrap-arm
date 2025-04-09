use <../riser_base/riser_base.scad>;
use <../riser_upper/riser_upper.scad>;

module bearing_riser() {
 	color("#E3E8EC") {
		union() {
			riser_base();
			riser_upper();
		}
	}
}

translate([50, 0, 0]) {
	riser_base();
}

translate([-38, 0, 0]) {
	riser_upper();
}
