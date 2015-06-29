include <vars.scad>;

// variables for rotational profile
y1 = 0;
y2 = thick;
y3 = y2 + thick + clear;
y4 = y3 + (thick - (clear*2));

x1 = inner + clear;
x2 = outer - (thick * 1.5) + clear;
x3 = outer - thick + clear;
x4 = outer;

slotsize = x4 - x2;

module disc()
{
	rotate_extrude()	
	polygon(points=[[x1, y1], [x1, y2], [x3, y2],[x3, y3], [x2, y3], [x2, y4], [x4, y4],[x4, y1]]);
}


// variables for the cutout
angle = (360/5)/2;
p1x = cos(angle * 1.001) * 30;
p1y = sin(angle * 1.001) * 30;
p2x = cos(-angle) * 30;
p2y = sin(-angle) * 30;

union()
{
    translate([outer-slotsize,-0.9,0])
    cube([slotsize,1.8,thick*2.2]);
    
    
	translate([holes_rad, 0, 0])
	difference()
	{
		translate([0,0,0])
		cylinder(r=2, h=thick*2);

		translate([0, 0, y2-4])
		cylinder(r=shaft_r, h=10);
        // rotate_extrude()	
		// polygon(points=[[0,0], [shaft_r2, 0], [shaft_r2, shaft_h2], [shaft_r, shaft_h2], [shaft_r, 10], [0, 10]]);
	};

	difference()
	{
		disc();

		translate([0, 0, -2])
		linear_extrude(20)
		polygon(points=[[-30, 30], [30, 30], [p1x, p1y], [0,0], [p2x, p2y], [30, -30], [-30, -30]]);
	};
};