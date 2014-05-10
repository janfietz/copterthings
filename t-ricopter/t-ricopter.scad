/* [Global] */

/* [Plate] */
plate_thickness = 4.0; //

/* [Booms] */
boom_height = 20.0;
boom_width = 20.0;

main();
module trapezoid(bottom, top, height, z){
	linear_extrude(height = z, center = true, convexity = 10) polygon( points=[[-bottom/2,-height/2],[bottom/2,-height/2],[top/2,height/2],[-top/2,height/2]] );
}

module baseplate() {
	union() {
		cube(size = [90.0, 50.0, plate_thickness], center = true);
		translate([0,85.0,0]) rotate ([0,0,0]) trapezoid(bottom = 90.0, top = 50.0, height = 120.0, z = plate_thickness);
	}
}

module yaw_connector() {
	difference() {
		cube(size = [boom_width + 20.0, 40.0, boom_height/2], center = true);
		translate([0,3.0,0]) cube(size = [boom_width, 40.0, boom_height/2+1], center = true);
	}
}
module t_connector() {
	difference() {
		cube(size = [90.0, boom_width+10.0, boom_height/2], center = true);
		translate([0,2.0,0]) cube(size = [91.0, boom_width, boom_height/2+1], center = true);
	}
}

module main() {
	union() {
		baseplate();
		translate([0,125.0,boom_height/4]) yaw_connector();
		translate([0,-10.0,boom_height/4]) t_connector();
	}
}