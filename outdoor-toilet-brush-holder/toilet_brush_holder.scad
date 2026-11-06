// Main part file. Open in OpenSCAD: F5 preview, F6 render.
// Viewed from above, X is to the right and Y is away from you.
//
// A round cup for a toilet brush head, with a drain hole in the floor and
// three long tapered legs that spread out from the base. Under the tip of each
// leg a separate foot pushes into a socket. The feet are the only parts that
// touch the ground, so three points of contact always find the ground and it
// doesn't rock on uneven ground.
//
// Notes:
// - The holder prints as modelled, legs flat on the bed, no supports. The
//   sockets open onto the bed, so they print without supports too. The legs
//   are plates lying along the layers, so they are strong against being knocked.
// - The foot is modelled the way it prints: plug end on the bed, point up. The
//   taper is shallow everywhere, so it needs no supports. It wedges into the
//   socket and stops where it gets tight, so the seating depth varies a little.
//   Print one foot per leg.
// - Keep comments on parameters to a single line: the single-file build
//   (make dist) drops comments that continue over several lines.

/* [Part] */
part = "all"; // [holder, foot, all]

/* [Brush] */
brush_diameter = 90;  // mm, widest part of the brush head
clearance      = 3;   // mm, total extra width so the brush slides in, raise if it fits tight

/* [Cup] */
cup_height      = 120; // mm, outside, including the floor
wall_thickness  = 3;   // mm
floor_thickness = 3;   // mm
drain_diameter  = 12;  // mm, hole in the middle of the floor

/* [Legs] */
leg_count     = 3;   // number of legs, and feet
leg_reach     = 120; // mm, from the cup centre to the leg tip, 2 x reach must fit the bed
leg_thickness = 15;  // mm, at the tip, must be deeper than the socket
leg_width     = 40;  // mm, where the leg meets the cup
leg_tip_width = 28;  // mm, at the tip, wider than the foot
gusset_height = 45;  // mm, how high the leg climbs up the cup, it slopes down to the tip
leg_angle     = 90;  // degrees, direction of the first leg, 90 = away from you

/* [Feet] */
foot_diameter = 14;  // mm, widest point, level with the underside of the leg
foot_height   = 15;  // mm, below the leg, how far the cup floor stands off the ground
foot_tip      = 2;   // mm, diameter of the point, 0 = needle, larger grips paving better
plug_length   = 8;   // mm, the tapered part that pushes into the leg
plug_taper    = 5;   // degrees, each side, shallow enough to wedge tight
fit_clearance = 0.1; // mm, gap on each side at the socket mouth, raise if too tight
socket_depth  = 12;  // mm, deeper than the plug can sink, less than the leg thickness

/* [Finish] */
cup_chamfer = 1; // mm, 45 degree chamfer on the top rim

$fn = 120;

inner_d = brush_diameter + clearance;
outer_r = inner_d / 2 + wall_thickness;

module leg() {
    hull() {
        // Tall end, merges into the cup wall.
        translate([outer_r - leg_width / 2, 0, 0])
            cylinder(d = leg_width, h = gusset_height);
        // Thin end, lies on the bed.
        translate([leg_reach - leg_tip_width / 2, 0, 0])
            cylinder(d = leg_tip_width, h = leg_thickness);
    }
}

module holder() {
    difference() {
        union() {
            cylinder(r = outer_r, h = cup_height);
            for (i = [0 : leg_count - 1])
                rotate(leg_angle + i * 360 / leg_count) leg();
        }
        // Brush cavity.
        translate([0, 0, floor_thickness])
            cylinder(d = inner_d, h = cup_height);
        // Drain.
        translate([0, 0, -1]) cylinder(d = drain_diameter, h = floor_thickness + 2);
        // Rim chamfer.
        translate([0, 0, cup_height - cup_chamfer])
            difference() {
                cylinder(r = outer_r + 1, h = cup_chamfer + 1);
                cylinder(r1 = outer_r, r2 = outer_r - cup_chamfer - 1, h = cup_chamfer + 1);
            }
        // Foot sockets, tapered to match the foot, open to the bed.
        for (i = [0 : leg_count - 1])
            rotate(leg_angle + i * 360 / leg_count)
                translate([leg_reach - leg_tip_width / 2, 0, -1])
                    cylinder(d1 = foot_diameter + 2 * fit_clearance + 2 * tan(plug_taper),
                             d2 = foot_diameter + 2 * fit_clearance - 2 * socket_depth * tan(plug_taper),
                             h = socket_depth + 1, $fn = 48);
    }
}

module foot() {
    // Plug end on the bed, widening to the full diameter, then a cone to the point.
    cylinder(d1 = foot_diameter - 2 * plug_length * tan(plug_taper), d2 = foot_diameter,
             h = plug_length, $fn = 48);
    translate([0, 0, plug_length - 0.01])
        cylinder(d1 = foot_diameter, d2 = foot_tip, h = foot_height + 0.01, $fn = 48);
}

if (part == "holder") holder();
else if (part == "foot") foot();
else {
    // Preview: the holder with a row of feet in front of it.
    holder();
    for (i = [0 : leg_count - 1])
        translate([(i - (leg_count - 1) / 2) * (foot_diameter + 5), -outer_r - foot_diameter, 0]) foot();
}
