include <vars.scad>

difference()
{
	cylinder(r=outer-thick-clear, h=2);

	union()
	{
		translate([0,0,-5])
		makeGuides(outer-thick, 1.1, 10);
	
		translate([0,0,-5])
		makeGuides(holes_rad, shaft_r, 10);
		
		translate([0,0,-5])
		cylinder(r=inner+clear, h=10);
	}
}