include <vars.scad>;

//// Copyright 2011 Cliff L. Biffle.
//// This file is licensed Creative Commons Attribution-ShareAlike 3.0.
//// http://creativecommons.org/licenses/by-sa/3.0/
//
//// You can get this file from http://www.thingiverse.com/thing:3575
//use <libs/parametric_involute_gear_v5.0.scad>
//
//// Couple handy arithmetic shortcuts
//function sqr(n) = pow(n, 2);
//function cube(n) = pow(n, 3);
//
//// This was derived as follows:
//// In Greg Frost's original script, the outer radius of a spur
//// gear can be computed as...
//function gear_outer_radius(number_of_teeth, circular_pitch) =
//	(sqr(number_of_teeth) * sqr(circular_pitch) + 64800)
//		/ (360 * number_of_teeth * circular_pitch);
//
//// We can fit gears to the spacing by working it backwards.
////  spacing = gear_outer_radius(teeth1, cp)
////          + gear_outer_radius(teeth2, cp);
////
//// I plugged this into an algebra system, assuming that spacing,
//// teeth1, and teeth2 are given.  By solving for circular pitch,
//// we get this terrifying equation:
//function fit_spur_gears(n1, n2, spacing) =
//	(180 * spacing * n1 * n2  +  180
//		* sqrt(-(2*n1*cube(n2)-(sqr(spacing)-4)*sqr(n1)*sqr(n2)+2*cube(n1)*n2)))
//	/ (n1*sqr(n2) + sqr(n1)*n2);
//
//module gears(which) 
//{
//	n1 = 35; n2 = 7;
//	p = fit_spur_gears(n1, n2, 15);
//	
//    // big gear
//    if (which % 2 == 1)
//    {
//        gear (circular_pitch=p,
//            gear_thickness = 7,
//            rim_thickness = 5,
//            hub_thickness = 7,
//            number_of_teeth = n1,
//            circles=5,
//            bore_diameter=0);
//	}
//    
//    if (which < 3)
//    {
//        // little gear
//        
//        translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,0])
//        // translate([0,0,10])
//        gear (circular_pitch=p,
//            gear_thickness = 7,
//            rim_thickness = 7,
//            hub_thickness = 7,
//            circles=8,
//            number_of_teeth = n2,
//            rim_width = 0,
//            bore_diameter=0);
//    }
//        
//    $fn = 20;
//        translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,0])
//        cylinder(r=0.5, h=30);
//}

	n1 = 35; n2 = 7;
	p = fit_spur_gears(n1, n2, 15);


        gear (circular_pitch=p,
            gear_thickness = 12,
            rim_thickness = 15,
            hub_thickness = 17,
            number_of_teeth = n1,
            circles=5,
            bore_diameter=3);

// gears(1);