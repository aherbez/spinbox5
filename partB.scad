include <vars.scad>;
include <libs/Thread_Library.scad>;
// include <makeGears.scad>;

$fn = 100;

module thread()
{
    trapezoidThread(
        length=thr_length, 			    // axial length of the threaded rod 
        pitch=pitch, 			    // axial distance from crest to crest
        pitchRadius=pitchRadius, 	// radial distance from center to mid-profile
        threadHeightToPitch=0.5, 	// ratio between the height of the profile and the pitch 
                                    // std value for Acme or metric lead screw is 0.5
        profileRatio=0.5, 			// ratio between the lengths of the raised part of the profile and the pitch
                                    // std value for Acme or metric lead screw is 0.5
        threadAngle=30,			    // angle between the two faces of the thread 
                                    // std value for Acme is 29 or for metric lead screw is 30
        RH=false, 				    // true/false the thread winds clockwise looking along shaft, i.e.follows the Right Hand Rule
        clearance=0.1, 			    // radial clearance, normalized to thread height
        backlash=0.1, 			    // axial clearance, normalized to pitch
        stepsPerTurn=24 			// number of slices to create per turn
    );
}

difference()
{
    difference()
    {
        union()
        {
            // topmost disk
            translate([0,0,bottomheight/2])
            cylinder(r=outer, h=bottomheight/2);
    
            // thinner disk connecting top and bottom
            cylinder(r=outer-(thick*1), h=bottomheight);
    
            // bottom disk
            cylinder(r=outer, h=(thick));
            
            // central shaft
            cylinder(r=inner, h=central_h); 

            // disk for holding this part to fivefold part D
            translate([0,0,bottomheight + thick + (clear*2)])
            cylinder(r=10.5, h=thick);

            translate([0,0,bottomheight + thick + (clear*2) + thick])
            gears(3, biggear_h);
        };

        // carve out the bottom a bit to save on material
        scale([1,1,0.3])
        sphere(r=outer-thick);
    };
    
    thread();
};

// thread();





