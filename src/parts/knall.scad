include <../main.scad>
use <../util.scad>
use <MCAD/regular_shapes.scad>

module hook() {
    width = (body_radius + shell_thickness) * 2;

    union() {
        cube([2, width, shell_thickness]);

        translate([0, width / 4, 0]) cube([2, width / 2, body_radius + shell_thickness]);

        translate([shell_thickness * 3 / 4, width * 3 / 4, body_radius + shell_thickness])
            rotate([90, 0, 0]) triangle_prism(width / 2, shell_thickness);
    }
}

module cover() {
    width = (body_radius + shell_thickness) * 2;
    length = body_length + shell_thickness * 2;

    translate([- length / 2, 0, 0])  union() {
        cube([length, width, shell_thickness]);

        translate([- 2, 0, 0]) hook();
        translate([length + 2, width, 0]) rotate([0, 0, 180]) hook();
    }
}

module knaller() {
    height = body_radius * 2 + shell_thickness;
    width = (body_radius + shell_thickness) * 2;
    length = body_length + shell_thickness * 2;

    difference() {
        translate([0, 0, height / 2]) cube([length, width, height], center = true);

        translate([0, 0, height / 2 + shell_thickness / 2])
            rotate([0, 90, 0]) polyhole(r = body_radius, h = body_length, center = true);

        translate([0, 0, body_radius * 1.5 + shell_thickness])
            cube([body_length, 2 * body_radius, body_radius], center = true);

        *translate([- body_length / 2 + fuse_pos, body_length / 2, height / 2])
            rotate([90, 0, 0]) polyhole(r = fuse_radius, h = body_length, center = true);

        translate([0, - width / 2, height + shell_thickness]) rotate([0, 180, 0]) cover();
    }
}