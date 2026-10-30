# Chicken water lid

A parametric 3D-printable round lid for a chicken water cube, written in [OpenSCAD](https://openscad.org/).

It has a flat top, a lip rising from the edge, and ribs on the same side as the lip: two concentric rings and a star of radial ribs. A rib-free flat band is left inside the lip so the lid seats against the cube. The model is built upside down, so it prints with the top plate on the bed.

## Usage

1. Open `chicken-water-lid.scad` in OpenSCAD.
2. Edit the parameters at the top of the file.
3. Render (F6) and export as STL (F7). Exported STLs go in `stl/`, which is git-ignored.

Or from the command line:

```sh
openscad -o stl/chicken-water-lid.stl chicken-water-lid.scad
```

## Parameters

| Parameter | Meaning |
| --- | --- |
| `lid_diameter` | Outer diameter in mm |
| `top_thickness` | Thickness of the flat top plate in mm |
| `lip_thickness` | Radial thickness of the lip wall in mm |
| `lip_height` | Height of the lip above the top plate in mm |
| `flat_margin` | Rib-free flat band between the lip's inner face and the outer ring, in mm |
| `rib_thickness` | Width of every rib in mm |
| `rib_height` | Height of the ribs above the top plate in mm |
| `radial_rib_count` | Number of radial ribs in the star pattern |
| `cable_slot_diameter` | Width of the cable slot, and diameter of its rounded inner end, in mm |

The outer ring sits just inside the flat band, the inner ring is halfway between the outer ring and the centre, and the radial ribs run from the centre to the outer ring.

The cable slot cuts through the lip, plate and ribs from the edge inwards. It stops at the inner edge of the flat margin and ends in a semicircle centred there, so it reaches `cable_slot_diameter / 2` past that edge. It sits halfway between two radial ribs.
