// Chicken water lid: a round lid with a lip (wall) rising from its edge.
// Modelled and printed upside down: the top plate sits on the bed at z = 0
// and the lip rises from its edge.

// --- Lid ---
lid_inner_diameter = 245;   // mm, measured inside the lip walls
top_thickness = 3;          // mm, the flat plate

// --- Lip (wall rising from the edge) ---
lip_thickness = 2;          // mm, radial
lip_height = 10;            // mm, measured above the top plate

// --- Ribs (stiffen the top plate, rise from the same side as the lip) ---
flat_margin = 15;           // mm, rib-free flat band between the lip's inner face and the outer ring
rib_thickness = 1.6;        // mm, width of every rib
rib_height = 6;             // mm, measured above the top plate
radial_rib_count = 8;       // star pattern, centre to outer ring

// --- Cable slot (cuts through everything, from the edge inwards) ---
cable_slot_diameter = 6;   // mm, slot width; also the diameter of its rounded inner end

// ============================================================
// Parameters end here. Nothing below this line is meant to be edited.
// ============================================================

$fn = 256;  // high accuracy; slow renders are fine

inner_radius = lid_inner_diameter / 2;
lid_radius = inner_radius + lip_thickness;
overlap = 0.01;             // avoids coincident faces in the union

// Outer ring's outer face sits flat_margin in from the lip's inner face.
outer_ring_radius = inner_radius - flat_margin - rib_thickness / 2;
inner_ring_radius = outer_ring_radius / 2;

module ring(r) {
  difference() {
    cylinder(r = r + rib_thickness / 2, h = rib_height + overlap);
    translate([0, 0, -overlap])
      cylinder(r = r - rib_thickness / 2, h = rib_height + 3 * overlap);
  }
}

// The slot runs in from the edge to the inner edge of the flat margin, then
// ends in a semicircle. It sits halfway between two radial ribs.
slot_end_radius = inner_radius - flat_margin;

module cable_slot() {
  rotate(180 / radial_rib_count)
    translate([0, 0, -1])
      linear_extrude(top_thickness + lip_height + 2) {
        translate([slot_end_radius, 0]) circle(d = cable_slot_diameter);
        translate([slot_end_radius, -cable_slot_diameter / 2])
          square([lid_radius, cable_slot_diameter]);
      }
}

difference() {
  union() {
    cylinder(r = lid_radius, h = top_thickness);

    translate([0, 0, top_thickness - overlap]) {
      ring(outer_ring_radius);
      ring(inner_ring_radius);
      for (i = [0 : radial_rib_count - 1])
        rotate(i * 360 / radial_rib_count)
          translate([0, -rib_thickness / 2, 0])
            cube([outer_ring_radius, rib_thickness, rib_height + overlap]);
    }

    translate([0, 0, top_thickness - overlap])
      difference() {
        cylinder(r = lid_radius, h = lip_height + overlap);
        translate([0, 0, -overlap])
          cylinder(r = inner_radius, h = lip_height + 3 * overlap);
      }
  }
  cable_slot();
}
