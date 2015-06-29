include <vars.scad>;
include <libs/Thread_Library.scad>;

module makeGuides(radius, size, height)
{
	union() {
	
	for (i = [0 : 4])
	{
        rotate(i * (360/5),[0,0,1]){
            translate([radius, 0, 0])
            {
                cylinder(r=size, h=height);
            };
        };

        }
	};
}

module disc(radius, thick)
{
	difference()
	{
		union()
		{
			// cut out grooves for the guides
			difference() {
				cylinder(r=radius-0.1, h=thick);

				translate([0,0,-5]) {
					makeGuides(radius, 1.1, 10);
				};
			};
	
		
			for (i = [0 : 4])
			{
				rotate(i * (360/5),[0,0,1])
				{
					translate([holes_rad, 0, -hole_guide_h])
					{
						cylinder(r=holes_size+1, h=hole_guide_h+1);
					};
 				};		
			};
		};

		for (i = [0 : 4])
		{
			rotate(i * (360/5),[0,0,1])
			{
				translate([holes_rad, 0, -hole_guide_h-2])
				{
					cylinder(r=holes_size, h=hole_guide_h+6);
				
//					rotate_extrude()
//					polygon(points=[[0, -hole_guide_h-1], [holes_size, -hole_guide_h-1], [holes_size, 0.5], [holes_size+1, thick+1], [0, thick+1]]);
			
				};
 			};		
		};
	};
};

rad = outer - thick - clear;

union()
{
    disc(rad, thick);
    translate([0,0,-thr_length])
    thread();
};

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
        clearance=0.2, 			    // radial clearance, normalized to thread height
        backlash=0.2, 			    // axial clearance, normalized to pitch
        stepsPerTurn=24 			// number of slices to create per turn
    );
}

