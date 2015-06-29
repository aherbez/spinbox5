include <vars.scad>


union()
{
    shaft_h = 35 + thick + biggear_h;
    
    translate([0,0,-thick])
    cylinder(r=shaft_r-0.1, h=shaft_h-3);
    gears(2, biggear_h);
}