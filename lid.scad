include <vars.scad>;

tfont = "Copperplate";

module hinge()
{	
	translate([0,-hingewidth/6,0])
	rotate(-90, [1,0,0])
	{

		difference()
		{	
			union()
			{
				cube([outer+thick,thick,hingewidth/3]);

				translate([outer+thick,0,0])
				{
					cylinder(r=(thick),h=(hingewidth/3));
			
				};
			};
	
			translate([outer+thick,0,-(hingewidth*0.1)])
			cylinder(r=(hingepin_r), h=hingewidth*1.2);
		};
	};
}

union()
{
difference()
{
	union()
	{
		rotate(180, [1,0,0])
		hinge();

		cylinder(r=outer, h=thick);
	}

	translate([0,0,thick-1])
	cylinder(r=outer-thick, h=thick*2);
};

}


