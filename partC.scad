// all units in millimeters

include <vars.scad>;


// draw the profile for revolving
module profile(outer, thick, height)
{
	totalheight = height + (thick * 3);
	
	inner = outer - (thick);
	inner2 = outer - (thick * 3);	
	inner3 = outer - (thick * 2);
	
	difference() 
	{
	difference() 
	{
		difference() 
		{

			difference() {
				union()
				{
					cylinder(r=outer, h=totalheight);
					translate([0,0,totalheight])
					hinge();
				}
				translate([0,0,thick*3]) {
					cylinder(r=inner, h=totalheight);
				};	
			};	

			translate([0,0,-thick]) {
				cylinder(r=inner2, h=totalheight*1.2);
			};
		};
	
		difference() {
			translate([0,0,thick]) {
				cylinder(r=outer+thick, h=thick);
			}
			cylinder(r=inner3, h=100);
		};
	};
		translate([0,0, -1]){	
			difference() {
				cylinder(r=outer+thick, h=thick*2);
				translate([0,0,-thick]) {
					cylinder(r=inner, h=100); };
			};
		};
	};
}

module makeGuides(radius, size, height)
{
	for (i = [0:4])
	{
		rotate([0,0,i*72]){
			translate([radius, 0, 0])
			{
				cylinder(r=size, h=height);
			};
		};	
	}
}


module gearcapSupport()
{
	difference()
	{
		cylinder(r=outer, h=thick);

		translate([0,0,-thick])
		cylinder(r=outer-(thick*2), h=(thick*3));
	};
}

module partA(outer, thick, height)
{
	union() 
	{	
        
		translate([0,0, gearcap_height])
		{gearcapSupport();};

        translate([0,0, thick*3]){
		makeGuides(outer-thick, 1, 40);	
	};

	profile(outer, thick, height);
	}
}

module hinge()
{	
	translate([0,-hingewidth/2,0])
	rotate(-90, [1,0,0])
	{
	difference()
	{
		difference()
		{	
			union()
			{
				cube([outer+thick,thick,hingewidth]);

				translate([outer+thick,0,0])
				{
					cylinder(r=(thick),h=hingewidth);
			
				};
			};
	
			translate([outer+thick,0,-(hingewidth*0.1)])
			cylinder(r=(hingepin_r), h=hingewidth*1.2);
		};
	
		translate([outer-thick,-thick,hingewidth * (1-0.36)/2])
		cube([thick*3, thick*3, (hingewidth * 0.36)]);

	};
	};
}


module fivePartGaps(outerR, innerR, height, uprightW)
{
    difference()
    {
    
        difference()
        {
            cylinder(r=outerR, h=height);
            translate([0,0,-1])
            cylinder(r=innerR, h=height+2);
        };

        union()
        {
            for (i = [0:4])
            {
                rotate(72*i, [0,0,1])
                translate([-uprightW/2,0,-1])
                cube([uprightW, outerR+4, 44]);
            };
        };
    
    };
}



difference()
{
    difference()
    {
        partA(outer, thick, bodyheight);
        rotate(-18, [0,0,1])
        translate([0,0,9])
        fivePartGaps(outer+4, outer-1, 37, thick);
    };
    
    union()
    {
        for (i = [0:4])
        {
            rotate(72*i, [0,0,1]) 
            translate([outer-5,-1,-1])
            cube([5,2,5]);
            
        };   
    };
};