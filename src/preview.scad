include <main.scad>
use <parts/knall.scad>

module knaller_inner_preview(off = 0) {
    difference() {
        knaller();

        height = (body_radius + shell_thickness) * 2;
        width = (body_radius + shell_thickness) * 2;
        length = body_length + shell_thickness * 2;
        translate([0, 0, height + off]) cube([length + .005, width + .005, height + .005], center = true);
    }
}

//knaller_inner_preview(body_radius);
knaller();