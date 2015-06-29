$fn = 200;
use <libs/parametric_involute_gear_v5.0.scad>


// base variables
inner = 7.5;
outer = 27.5;
thick = 3;
clear = 0.1;

bodyheight = 40;
guiderad = 1;

bottomheight = 10;

// holes_rad = 17;
holes_size = 6;
hole_guide_h = 10;

shaft_r = 1.1;
shaft_r2 = 1;
shaft_h2 = 1.5;


hingewidth = 15;
hingepin_r = 1;

thr_length=35;
pitch=5;
pitchRadius=5; 

central_h = 20;
biggear_h = central_h - bottomheight - (clear * 2) - (thick * 2); 

gearcap_height = (thick + biggear_h) + clear;


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

function sqr(n) = pow(n, 2);
function cube(n) = pow(n, 3);

function gear_outer_radius(number_of_teeth, circular_pitch) =
	(sqr(number_of_teeth) * sqr(circular_pitch) + 64800)
		/ (360 * number_of_teeth * circular_pitch);

function fit_spur_gears(n1, n2, spacing) =
	(180 * spacing * n1 * n2  +  180
		* sqrt(-(2*n1*cube(n2)-(sqr(spacing)-4)*sqr(n1)*sqr(n2)+2*cube(n1)*n2)))
	/ (n1*sqr(n2) + sqr(n1)*n2);


n1 = 35; n2 = 7;
p = fit_spur_gears(n1, n2, 15);


module gears(which, g_h) 
{
	
    // big gear
    if (which % 2 == 1)
    {
        gear (circular_pitch=p,
            gear_thickness = g_h,
            rim_thickness = g_h,
            hub_thickness = g_h,
            number_of_teeth = n1,
            circles=5,
            bore_diameter=0);
	}
    
    if (which < 3)
    {
        // little gear
        
        // translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,0])
        // translate([0,0,10])
        gear (circular_pitch=p,
            gear_thickness = 7,
            rim_thickness = 7,
            hub_thickness = 7,
            circles=8,
            number_of_teeth = n2,
            rim_width = 0,
            bore_diameter=0);
    }
        
    // translate([gear_outer_radius(n1, p) + gear_outer_radius(n2, p),0,0])
    // cylinder(r=0.5, h=30);
}

holes_rad = gear_outer_radius(n1, p) + gear_outer_radius(n2, p);