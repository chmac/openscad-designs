// Main part file. Open in OpenSCAD: F5 preview, F6 render.
// Viewed from above, X is to the right (width) and Y is away from you (depth).
//
// The box is open at the top. The lid is a plate the full outer size of the
// box, with a ring underneath that steps inwards and drops inside the box
// walls to hold the lid in place.
//
// The front of the box can carry a holder for a sign: a channel on the
// outside of the wall, open at the top, that a flat sign card drops into. The
// sides of the channel overhang the edges of the card to hold it against the
// wall.
//
// Notes:
// - The lid is modelled upside down, plate on the bed, so it prints without
//   supports.
// - Keep comments on parameters to a single line: the single-file build
//   (make dist) drops comments that continue over several lines.

/* [Part] */
part = "all"; // [box, lid, sign, all]

/* [Box] */
width           = 150; // mm, outer, along X
depth           = 100; // mm, outer, along Y
height          = 120; // mm, outer, box only, not including the lid
wall_thickness  = 0;   // mm, side walls and the lid ring, 0 = auto from the box size
floor_thickness = 3;   // mm

/* [Finish] */
corner_radius = 5; // mm, vertical corners of the box and lid
edge_chamfer  = 1; // mm, 45 degree chamfer on the bottom edge of the box and the top edge of the lid
slot_chamfer  = 1; // mm, 45 degree chamfer round the top of the money slot
lid_overhang  = 1; // mm, how far the lid sticks out past the box on every side, hides the seam

/* [Printing] */
line_width = 0.45; // mm, slicer extrusion width, auto sizes are a whole number of lines

/* [Lid] */
lid_thickness = 3;   // mm, top plate
ring_height   = 5;   // mm, how far the ring under the lid reaches down into the box
clearance     = 0.2; // mm, gap on each side between the lid ring and the box walls
slot_length   = 60;  // mm, along X
slot_width    = 5;   // mm, along Y

/* [Sign] */
add_sign_holder    = true;  // add a holder for a sign card on the front of the box
sign_on_short_side = true; // put the holder on a short side of the box instead of a long side
sign_width         = 80;   // mm, card, the part that slides into the holder
sign_height        = 50;   // mm, card, the part that slides into the holder, not including the lip
sign_thickness     = 1;     // mm, card
sign_overhang      = 5;     // mm, how far each side of the holder covers the edge of the card
sign_base          = 0;     // mm, thickness of the ledge the card stands on, 0 = auto (same as the sides)
sign_clearance     = 0.3;   // mm, gap around the card in the holder
sign_holder_thickness = 0;  // mm, sides and front of the holder, 0 = auto (3 lines)

/* [Hidden] */
part_gap = 10; // mm, space between the parts when part = "all"
eps      = 0.01;
$fa      = 4;
$fs      = 0.4;

// Auto wall: about 1 mm per 50 mm of the largest dimension, clamped to
// 1.2-4 mm, then rounded up to a whole number of lines.
wall = wall_thickness > 0
    ? wall_thickness
    : ceil(min(max(max(width, depth, height) / 50, 1.2), 4) / line_width) * line_width;

// Inset from the outer edge to the outside and inside of the lid ring.
ring_outer_inset = wall + clearance;
ring_inner_inset = ring_outer_inset + wall;

// The sign holder goes on the front (Y = 0) face when that is the side asked
// for, otherwise on the left (X = 0) face.
sign_along_x = (width >= depth) != sign_on_short_side;
sign_face    = sign_along_x ? width : depth;

// Sign holder sizes: the channel the card sits in, and the holder overall.
holder_wall         = sign_holder_thickness > 0 ? sign_holder_thickness : 3 * line_width;
sign_slot_width     = sign_width + 2 * sign_clearance;
sign_slot_thickness = sign_thickness + sign_clearance;
holder_width        = sign_slot_width + 2 * holder_wall;
holder_thickness    = sign_slot_thickness + holder_wall;
// Width of the frame around the sign as seen from the front: the sides of the
// holder, the ledge at the bottom and the lip on the card at the top.
frame_border        = holder_wall + sign_overhang;
holder_base         = sign_base > 0 ? sign_base : frame_border;
holder_height       = holder_base + sign_height; // card top, below the lip, is flush with the holder top
holder_z            = (height - holder_height - frame_border) / 2; // holder and lip centred vertically on the box

assert(ring_height < height - floor_thickness, "ring_height must be less than the inside height");
assert(slot_length < width - 2 * ring_inner_inset && slot_width < depth - 2 * ring_inner_inset,
       "slot must fit inside the lid ring");
assert(2 * corner_radius <= min(width, depth), "corner_radius must be at most half the width and depth");
assert(edge_chamfer < floor_thickness && edge_chamfer < lid_thickness,
       "edge_chamfer must be less than floor_thickness and lid_thickness");
assert(slot_chamfer < lid_thickness, "slot_chamfer must be less than lid_thickness");
assert(!add_sign_holder || holder_width <= sign_face - 2 * corner_radius,
       "sign holder is wider than the flat part of the side of the box");
assert(2 * sign_overhang < sign_slot_width, "sign_overhang must be less than half the sign width");
assert(sign_overhang > sign_clearance, "sign_overhang must be more than sign_clearance");
assert(!add_sign_holder || holder_z >= holder_thickness,
       "sign holder is too tall for the box, reduce sign_height or sign_base");

echo(wall = wall);

// In local coordinates: the holder is centred along X on a face running from
// 0 to face_length, and sticks out towards -Y from the wall at Y = 0.
module sign_holder(face_length) {
    translate([(face_length - holder_width) / 2, -holder_thickness, holder_z]) {
        difference() {
            cube([holder_width, holder_thickness + eps, holder_height]);
            // Channel the card drops into. Stops eps short of the box wall so
            // its back face isn't coplanar with the wall (flickers in preview).
            translate([holder_wall, holder_wall, holder_base])
                cube([sign_slot_width, sign_slot_thickness - eps, holder_height]);
            // Window in the front, leaving the overhang on each side.
            translate([holder_wall + sign_overhang, -eps, holder_base])
                cube([sign_slot_width - 2 * sign_overhang, holder_wall + 2 * eps, holder_height]);
        }
        // 45 degree chamfer under the holder, so it prints without supports.
        hull() {
            translate([0, 0, -eps])
                cube([holder_width, holder_thickness + eps, eps]);
            translate([0, holder_thickness, -holder_thickness])
                cube([holder_width, eps, eps]);
        }
    }
}

// The box outline seen from above, shrunk by inset on every side (grown, if
// inset is negative), with the corner radius changed to match so the corners
// stay concentric.
module outline(inset = 0) {
    r = max(corner_radius - inset, 0);
    translate([inset + r, inset + r])
        offset(r = r) square([width - 2 * (inset + r), depth - 2 * (inset + r)]);
}

// The outline, shrunk by inset, extruded to height h, with a 45 degree
// chamfer of size c round the bottom edge.
module chamfered_slab(h, c, inset = 0) {
    hull() {
        linear_extrude(eps) outline(inset + c);
        translate([0, 0, c]) linear_extrude(h - c) outline(inset);
    }
}

module box() {
    difference() {
        chamfered_slab(height, edge_chamfer);
        translate([0, 0, floor_thickness])
            linear_extrude(height) outline(wall);
    }
    if (add_sign_holder) {
        if (sign_along_x) sign_holder(width);
        else mirror([1, -1, 0]) sign_holder(depth); // swap X and Y
    }
}

module lid() {
    difference() {
        union() {
            chamfered_slab(lid_thickness, edge_chamfer, -lid_overhang); // top face is on the bed
            translate([0, 0, lid_thickness - eps])
                linear_extrude(ring_height + eps) outline(ring_outer_inset);
        }
        // Hollow out the ring.
        translate([0, 0, lid_thickness])
            linear_extrude(ring_height + eps) outline(ring_inner_inset);
        // Money slot, widened by the chamfer at the top face.
        translate([(width - slot_length) / 2, (depth - slot_width) / 2, 0])
            hull() {
                translate([-slot_chamfer, -slot_chamfer, -eps])
                    cube([slot_length + 2 * slot_chamfer, slot_width + 2 * slot_chamfer, eps]);
                translate([0, 0, slot_chamfer])
                    cube([slot_length, slot_width, lid_thickness - slot_chamfer + eps]);
            }
    }
}

// Printed back down. Y is up when the card is in the holder. The lip along the
// top rests on top of the holder and finishes the frame: it is as wide as the
// holder, as tall as the frame sides, and stands out flush with the holder
// front. Push it up to slide the card out. The card below the lip is
// sign_clearance short of the holder, so the lip, not the bottom of the card,
// is what it rests on.
module sign() {
    card_height = sign_height - sign_clearance;
    translate([(holder_width - sign_width) / 2, 0, 0])
        cube([sign_width, card_height + eps, sign_thickness]);
    translate([0, card_height, 0])
        cube([holder_width, frame_border, holder_thickness]);
}

if (part == "box" || part == "all") box();
if (part == "lid") lid();
if (part == "sign") sign();
if (part == "all") {
    translate([width + part_gap, 0, 0]) lid();
    if (add_sign_holder) translate([width + part_gap, depth + part_gap, 0]) sign();
}
